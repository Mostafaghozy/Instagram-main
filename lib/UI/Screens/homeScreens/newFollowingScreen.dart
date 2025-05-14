import 'package:flutter/material.dart';
import 'package:instagram/UI/Screens/homeScreens/HomeScreen.dart';
import 'package:instagram/UI/Widgets/Gridview_widget.dart';
import 'package:instagram/UI/Widgets/buttonNavigationBar_widget.dart';
import 'package:instagram/UI/Widgets/storyListWidget.dart';

class Newfollowingscreen extends StatefulWidget {
  const Newfollowingscreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewfollowingscreenState createState() => _NewfollowingscreenState();
}

class _NewfollowingscreenState extends State<Newfollowingscreen>
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
    // هنا يمكن تنفيذ التنقل بين الشاشات إذا لزم الأمر
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  // يمسح جميع الصفحات السابقة
                );
              },
            ),
          ),
          centerTitle: true,
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'username',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.verified, color: Colors.blue, size: 18),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications_none),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/dog2.png"),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(children: [Text("1,234"), Text("Posts")]),
                          Column(children: [Text("10K"), Text("Followers")]),
                          Column(children: [Text("100"), Text("Following")]),
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
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Category/Genre text',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt #hashtag',
                      style: TextStyle(
                        color: Colors.black,
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
                            backgroundColor:
                                const Color.fromRGBO(0, 163, 255, 1),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            side: const BorderSide(color: Colors.transparent)),
                        child: const Text(
                          'Follow',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
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
                                backgroundColor: const Color(0xFFEFEFEF),
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(105, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              child: const Text(
                                'Message',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
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
                                backgroundColor:
                                    const Color.fromRGBO(239, 239, 239, 1),
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(105, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              child: const Text(
                                'Subscribe',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
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
                                backgroundColor:
                                    const Color.fromRGBO(239, 239, 239, 1),
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(105, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              child: const Text(
                                'Contact',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFF1F1F1),
                            minimumSize: const Size(40, 30),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          child: const Icon(
                            Icons.person_add_outlined,
                            size: 18,
                            color: Colors.black,
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
