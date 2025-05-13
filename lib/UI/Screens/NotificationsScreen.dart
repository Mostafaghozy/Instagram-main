import 'package:flutter/material.dart';
import 'package:instagram/UI/Widgets/buttonNavigationBar_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Following"),
            Tab(text: "You"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SingleChildScrollView(child: NotificationsList()),
          SingleChildScrollView(child: NotificationsList()),
        ],
      ),
      bottomNavigationBar: NavBar(
        onItemSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // لمنع التمرير الداخلي
      children: [
        _buildSectionTitle("Follow Requests"),
        _buildDivider(),
        _buildSectionTitle("New"),
        _buildNotificationItem("karenne", "liked your photo.", "1h",
            showImage: true),
        _buildDivider(),
        _buildSectionTitle("Today"),
        _buildNotificationItem("kiero_d", "liked your photo.", "3h",
            showImage: true),
        _buildDivider(),
        _buildSectionTitle("This Week"),
        _buildNotificationItem(
            "craig_love", "mentioned you in a comment.", "2d",
            showReply: true),
        _buildNotificationItem("martini_rond", "started following you.", "3d",
            showButton: true),
        _buildNotificationItem("maxjacobson", "started following you.", "3d",
            showButton: true),
        _buildNotificationItem("mis_potter", "started following you.", "3d",
            showFollowButton: true),
        _buildDivider(),
        _buildSectionTitle("This Month"),
        _buildNotificationItem(
            "craig_love", "mentioned you in a comment.", "2d",
            showReply: true),
        _buildNotificationItem("martini_rond", "started following you.", "3d",
            showButton: true),
        _buildNotificationItem("maxjacobson", "started following you.", "3d",
            showButton: true),
        _buildNotificationItem("mis_potter", "started following you.", "3d",
            showFollowButton: true),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String username, String action, String time,
      {bool showImage = false,
      bool showButton = false,
      bool showFollowButton = false,
      bool showReply = false}) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/dog2.png"),
          ),
          title: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                    text: "$username ",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: action),
              ],
            ),
          ),
          subtitle: Text(time,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          trailing: showImage
              ? Image.asset("assets/images/dog2.png",
                  width: 40, height: 40, fit: BoxFit.cover)
              //Button to message
              : showButton
                  ? OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        side: const BorderSide(color: Colors.transparent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        minimumSize: const Size(90, 28),
                      ),
                      child: const Text("Message",
                          style: TextStyle(color: Colors.black, fontSize: 13)),
                    )
                  //Button to follow
                  : showFollowButton
                      ? OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: const BorderSide(color: Colors.transparent),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            minimumSize: const Size(90, 28),
                          ),
                          child: const Text("Follow",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        )
                      //Reply button
                      : showReply
                          ? TextButton(
                              onPressed: () {},
                              child: const Text("Reply",
                                  style: TextStyle(color: Colors.blue)),
                            )
                          : null,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[300], thickness: 1);
  }
}
