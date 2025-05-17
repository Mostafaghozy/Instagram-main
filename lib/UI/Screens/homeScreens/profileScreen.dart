// ignore: file_names
import 'package:flutter/material.dart';
import 'package:instagram/UI/Widgets/Gridview_widget.dart';
import 'package:instagram/UI/Widgets/profile_tabs_widget.dart';
import 'package:instagram/UI/Widgets/buttonNavigationBar_widget.dart';
import 'package:instagram/UI/Widgets/storyListWidget.dart';
import '../../widgets/profile_action_buttons.dart'; // Import the ProfileActionButtons widget

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'username',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            Image.asset("assets/icons/Notifications10.png"),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_box_outlined,
                  size: 30,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon:
                    Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red, // Add red border color
                    child: CircleAvatar(
                      radius: 37,
                      backgroundImage: AssetImage('assets/images/dog2.png'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 70),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          Text("1,234",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text("Posts",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("10K",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text("Followers",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("100",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text("Following",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold))
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Category/Genre text',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt #hashtag',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 44, // enough for 3 overlapping avatars
                    child: Stack(
                      children: [
                        Positioned(
                          left: 24,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage:
                                AssetImage('assets/images/dog4.png'),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage:
                                AssetImage('assets/images/dog3.png'),
                          ),
                        ),
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: AssetImage('assets/images/dog2.png'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Followed by username, username \nand 100 others',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10),
              const ProfileActionButtons(),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: StoryListWidget(controller: _scrollController),
              ),
              ProfileTabs(tabController: _tabController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        onItemSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
