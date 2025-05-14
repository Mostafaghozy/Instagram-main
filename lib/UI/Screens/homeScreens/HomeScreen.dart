import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/UI/Screens/notification/NotificationsScreen.dart';
import 'package:instagram/UI/Screens/homeScreens/newFollowingScreen.dart';
import 'package:instagram/UI/Widgets/buttonNavigationBar_widget.dart';
import 'package:instagram/data/models/story_model.dart';
import 'package:instagram/data/services/story_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeState createState() => _HomeState();
}

int _selectedIndex = 0;
final ImagePicker _picker = ImagePicker();

class _HomeState extends State<HomeScreen> {
  String currentImage = 'assets/icons/like.png';
  List<StoryModel> stories = [];
  final StoryService _storyService = StoryService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  // Format timestamp to show time ago
  String formatTimestamp(DateTime timestamp) {
    final Duration difference = DateTime.now().difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Just now';
    }
  }

  Future<void> _loadStories() async {
    try {
      print('🔄 بدء تحميل القصص من Supabase...');
      final data = await _storyService.fetchStories();

      if (data.isEmpty) {
        print('❗ لا توجد قصص للعرض');
      } else {
        print('✅ تم تحميل ${data.length} قصة');
        // طباعة بعض معلومات القصص للتصحيح
        for (var story in data) {
          print(
              '📱 Story ID: ${story.id}, Image: ${story.imageUrl}, Time: ${story.timestamp}');
        }
      }

      setState(() {
        stories = data;
      });
    } catch (e) {
      print('❌ خطأ في تحميل القصص: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ خطأ في تحميل القصص: ${e.toString()}')),
        );
      }
    }
  }

  // Method to pick and upload image
  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);

      setState(() {
        isLoading = true;
      });

      try {
        print('🖼️ تم اختيار صورة، جاري الرفع...');
        final imageUrl = await _storyService.uploadImageToStorage(file);

        if (imageUrl != null) {
          print('🔗 تم الحصول على رابط الصورة: $imageUrl');
          await _storyService.saveStoryToDatabase(imageUrl);

          // انتظر لحظة قبل إعادة تحميل القصص لمنح Supabase وقتًا للمزامنة
          print('⏳ انتظار لتحديث البيانات...');
          await Future.delayed(const Duration(milliseconds: 2000));

          // إعادة تحميل القصص بعد الرفع
          print('🔄 إعادة تحميل القصص...');
          await _loadStories();

          if (mounted) {
            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ تم رفع القصة بنجاح')),
            );
          }
        } else {
          print('❌ فشل الحصول على رابط الصورة');
          if (mounted) {
            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('❌ فشل الرفع')),
            );
          }
        }
      } catch (e) {
        print('❌ خطأ في رفع الصورة: $e');
        if (mounted) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ حدث خطأ: ${e.toString()}')),
          );
        }
      }
    } else {
      print('⚠️ لم يتم اختيار صورة');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم اختيار صورة')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  File? uploadedPostImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/logo/instagram text logoBlack.png'
                  : 'assets/images/IG logo.png',
              width: 104,
              height: 30,
            ),
            const SizedBox(width: 2),
            const Icon(Icons.keyboard_arrow_down,
                size: 30, color: Colors.black),
          ],
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.heart, size: 24),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const NotificationsScreen()));
            },
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.facebookMessenger, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.add, size: 24),
            onPressed: () async {
              final picked =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (picked != null) {
                setState(() {
                  uploadedPostImage = File(picked.path);
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قائمة الستوري
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 15),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              InkWell(
                                onTap: isLoading ? null : pickAndUploadImage,
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey[300],
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.blue,
                                          ))
                                      : null,
                                ),
                              ),
                              if (!isLoading)
                                const Icon(Icons.add_circle,
                                    color: Colors.blue, size: 30),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text("Add",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      );
                    } else {
                      final story = stories[index - 1];
                      print('🖼️ عرض صورة الستوري: ${story.imageUrl}');
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print('📸 تم فتح Story من ${story.userId}');

                              // هنا يمكنك إضافة كود لعرض الستوري بشكل كامل
                              showDialog(
                                context: context,
                                barrierColor: Colors.black87,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.zero,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.8,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(story.imageUrl),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Text(
                                                '${formatTimestamp(story.timestamp)} ago',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 10.0,
                                                      color: Colors.black,
                                                      offset: Offset(1.0, 1.0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.white, size: 30),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 33,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: NetworkImage(story.imageUrl),
                                onBackgroundImageError:
                                    (exception, stackTrace) {
                                  print(
                                      '❌ خطأ في تحميل صورة الستوري: $exception');
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            story.userId
                                .substring(0, min(6, story.userId.length)),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            Divider(thickness: 3, color: Colors.grey[200]),

            const SizedBox(height: 10),

            // بقية المحتوى كما هو
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage('assets/images/dog2.png'),
                    radius: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 224, 114, 90),
                            width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const Newfollowingscreen()));
                    },
                    child: const Column(
                      children: [
                        Text("Ruffles",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        Text("Sponsored", style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz),
                ],
              ),
            ),
            Stack(
              children: [
                uploadedPostImage != null
                    ? Image.file(uploadedPostImage!,
                        fit: BoxFit.cover, height: 400, width: 400)
                    : Image.asset('assets/images/dog2.png',
                        fit: BoxFit.cover, height: 400, width: 400),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () => print('تم النقر على الصورة!'),
                    child: Image.asset('assets/icons/Tags.png',
                        width: 24, height: 24),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currentImage = currentImage == 'assets/icons/like.png'
                            ? 'assets/icons/red.png'
                            : 'assets/icons/like.png';
                      });
                    },
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/icons/likeBlack.png'
                          : currentImage,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/icons/MessageBlack.png'
                      : 'assets/icons/message.png',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/icons/shareBlack.png'
                      : 'assets/icons/share.png',
                  width: 24,
                  height: 24,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/icons/saveBlack.png'
                        : 'assets/icons/save.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '100 likes',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Username ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Newfollowingscreen())),
                    ),
                    const TextSpan(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur\n adipiscing elit, sed do eiusmod tempor incididunt... ',
                    ),
                    const TextSpan(
                      text: 'more',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('View all 16 comments',
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        onItemSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }

  // Helper function to avoid substring error if userId is too short
  int min(int a, int b) {
    return a < b ? a : b;
  }
}
