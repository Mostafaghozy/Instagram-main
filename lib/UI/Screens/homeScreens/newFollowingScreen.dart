import 'package:flutter/material.dart';
import 'package:instagram/UI/Screens/homeScreens/HomeScreen.dart';
import 'package:instagram/UI/Widgets/Gridview_widget.dart';
import 'package:instagram/UI/Widgets/buttonNavigationBar_widget.dart';
import 'package:instagram/UI/Widgets/storyListWidget.dart';

class Newfollowing extends StatefulWidget {
  const Newfollowing({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewfollowingState createState() => _NewfollowingState();
}

class _NewfollowingState extends State<Newfollowing>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color subTextColor = isDark ? Colors.white70 : Colors.black;
    Color cardColor = isDark ? const Color(0xFF232323) : Colors.white;
    Color buttonBg =
        isDark ? Colors.white : const Color.fromRGBO(0, 163, 255, 1);
    Color buttonText =
        isDark ? const Color.fromRGBO(0, 163, 255, 1) : Colors.white;
    Color outlineButtonBg =
        isDark ? const Color(0xFF232323) : const Color(0xFFEFEFEF);
    Color outlineButtonText = isDark ? Colors.white : Colors.black;
    Color iconColor = isDark ? Colors.white : Colors.black;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF181818) : Colors.white,
        appBar: AppBar(
          backgroundColor: isDark ? const Color(0xFF181818) : Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: iconColor),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ),
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'username',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.verified, color: Colors.blue, size: 18),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications_none, color: iconColor),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.more_horiz, color: iconColor),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          const AssetImage("assets/images/dog2.png"),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(children: [
                            Text("1,234", style: TextStyle(color: textColor)),
                            Text("Posts", style: TextStyle(color: subTextColor))
                          ]),
                          Column(children: [
                            Text("10K", style: TextStyle(color: textColor)),
                            Text("Followers",
                                style: TextStyle(color: subTextColor))
                          ]),
                          Column(children: [
                            Text("100", style: TextStyle(color: textColor)),
                            Text("Following",
                                style: TextStyle(color: subTextColor))
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Category/Genre text',
                      style: TextStyle(
                        color: subTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt #hashtag',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // Add login functionality
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: buttonBg,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          side: const BorderSide(color: Colors.transparent),
                        ),
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            fontSize: 15,
                            color: buttonText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: 105,
                            height: 30,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: outlineButtonBg,
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(105, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              child: Text(
                                'Message',
                                style: TextStyle(
                                    fontSize: 15, color: outlineButtonText),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: SizedBox(
                            width: 105,
                            height: 30,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: outlineButtonBg,
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(105, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              child: Text(
                                'Subscribe',
                                style: TextStyle(
                                    fontSize: 15, color: outlineButtonText),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: SizedBox(
                            width: 105,
                            height: 30,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: outlineButtonBg,
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(105, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              child: Text(
                                'Contact',
                                style: TextStyle(
                                    fontSize: 15, color: outlineButtonText),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: outlineButtonBg,
                            minimumSize: const Size(40, 30),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          child: Icon(
                            Icons.person_add_outlined,
                            size: 18,
                            color: iconColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 120, // تحديد ارتفاع مناسب
                      child: StoryListWidget(
                          controller: _scrollController), // ✅ تمرير الكنترولر
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.blue,
                      labelColor: isDark ? Colors.white : Colors.black,
                      unselectedLabelColor:
                          isDark ? Colors.white54 : Colors.black54,
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.grid_on),
                        ),
                        Tab(
                          icon: Icon(Icons.video_library),
                        ),
                        Tab(
                          icon: Icon(Icons.person),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 300, // يمكن تعديل الارتفاع حسب الحاجة
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          PhotosTab(),
                          VideosTab(),
                          ProfileTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavBar(
          onItemSelected: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}

class PhotosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GridviewWidget(),
    );
  }
}

class VideosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GridviewWidget(),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GridviewWidget(),
    );
  }
}
