import 'package:flutter/material.dart';

import 'package:instagram/UI/Widgets/buttonNavigationBar_widget.dart';

class SponsoredScreen extends StatefulWidget {
  SponsoredScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SponsoredState createState() => _SponsoredState();
}

int _selectedIndex = 1;

class _SponsoredState extends State<SponsoredScreen> {
  String currentImage = 'assets/icons/like.png'; // الصورة الافتراضية

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // هنا يمكن تنفيذ التنقل بين الشاشات إذا لزم الأمر
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/IG logo.png',
              width: 104,
              height: 30,
            ),
            const SizedBox(
              width: 2,
            ),
            InkWell(
              onTap: () {
                //action
              },
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                //action
              },
              child: Image.asset(
                'assets/icons/like.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                //action
              },
              child: Image.asset(
                'assets/icons/messenger.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                //action
              },
              child: Image.asset(
                'assets/icons/add.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100, // يمكن تعديل الارتفاع حسب الحاجة
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (index == 0) {
                                    print('تم النقر على إضافة استوري');
                                  } else {
                                    print(
                                        'تم النقر على الاستوري: ${index + 1}');
                                  }
                                  //action
                                },
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    // CircleAvatar
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: index == 0
                                          ? null // لا توجد صورة للعنصر الأول
                                          : const AssetImage(
                                              'assets/images/dog2.png'),
                                      backgroundColor: index == 0
                                          ? Colors.grey[
                                              300] // لون خلفية العنصر الأول
                                          : null,
                                    ),
                                    // أيقونة add للعنصر الأول فقط
                                    if (index == 0)
                                      const Icon(
                                        Icons.add_circle,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                  height: 5), // مسافة بين CircleAvatar والنص
                              Text(
                                index == 0
                                    ? "Add"
                                    : "Text${index}", // النص يعتمد على الفهرس
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ), // النص يعتمد على الفهرس
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 3,
              color: Colors.grey[200],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/dog2.png'),
                    radius: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 224, 114, 90),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      Text(
                        "Ruffles",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text("Sponsored", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),
            ),
            Container(
              // height: 400,
              // width: 400,
              child: Stack(
                children: [
                  // الصورة
                  Image.asset(
                    'assets/images/dog2.png',
                    fit: BoxFit.cover,
                    height: 400,
                    width: 400,
                  ),
                  // الأيقونة
                  Positioned(
                    bottom: 50,
                    left: 15, // المسافة من الأسفل
                    // المسافة من اليمين
                    child: InkWell(
                      onTap: () {
                        print('تم النقر على الصورة!');
                      },
                      child: Image.asset(
                        'assets/icons/Tags.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        print("تم الضغط على CTA!");
                      },
                      child: Container(
                        width: 400, // نفس عرض الصورة
                        height: 40, // ارتفاع الزر
                        color: Colors.blue, // لون الزر
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "CTA copy here",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Icon(Icons.chevron_right, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (currentImage == 'assets/icons/like.png') {
                          currentImage =
                              'assets/icons/red.png'; // الصورة الجديدة
                        } else {
                          currentImage =
                              'assets/icons/like.png'; // العودة إلى الصورة الأصلية
                        }
                      });
                    },
                    child: Image.asset(
                      currentImage, // استخدام المتغير لتحديد الصورة الحالية
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    //action
                  },
                  child: Image.asset(
                    'assets/icons/message.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    //action
                  },
                  child: Image.asset(
                    'assets/icons/share.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      //action
                    },
                    child: Image.asset(
                      'assets/icons/save.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('100 likes'),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontSize: 14), // نمط النص العادي
                  children: [
                    TextSpan(
                      text: 'Username ',
                      style: TextStyle(
                          fontWeight:
                              FontWeight.bold), // اجعل "Username" عريضًا
                    ),
                    TextSpan(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur\n adipiscing elit, sed do eiusmod tempor incididunt... ',
                    ),
                    TextSpan(
                      text: 'more',
                      style: TextStyle(
                          color:
                              Colors.grey), // "more" بلون رمادي (يمكن تغييره)
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
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
}
