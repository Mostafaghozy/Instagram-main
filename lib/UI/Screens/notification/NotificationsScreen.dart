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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text(""),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).textTheme.bodyLarge?.color,
          unselectedLabelColor: Theme.of(context).hintColor,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.grey;
    final tileColor = isDark ? const Color(0xFF232323) : Colors.white;
    final dividerColor = isDark ? Colors.grey[700] : Colors.grey[300];
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildSectionTitle("Follow Requests", textColor),
        _buildDivider(dividerColor),
        _buildSectionTitle("New", textColor),
        _buildNotificationItem("karenne", "liked your photo.", "1h", textColor,
            subTextColor, tileColor,
            showImage: true),
        _buildDivider(dividerColor),
        _buildSectionTitle("Today", textColor),
        _buildNotificationItem("kiero_d", "liked your photo.", "3h", textColor,
            subTextColor, tileColor,
            showImage: true),
        _buildDivider(dividerColor),
        _buildSectionTitle("This Week", textColor),
        _buildNotificationItem("craig_love", "mentioned you in a comment.",
            "2d", textColor, subTextColor, tileColor,
            showReply: true),
        _buildNotificationItem("martini_rond", "started following you.", "3d",
            textColor, subTextColor, tileColor,
            showButton: true),
        _buildNotificationItem("maxjacobson", "started following you.", "3d",
            textColor, subTextColor, tileColor,
            showButton: true),
        _buildNotificationItem("mis_potter", "started following you.", "3d",
            textColor, subTextColor, tileColor,
            showFollowButton: true),
        _buildDivider(dividerColor),
        _buildSectionTitle("This Month", textColor),
        _buildNotificationItem("craig_love", "mentioned you in a comment.",
            "2d", textColor, subTextColor, tileColor,
            showReply: true),
        _buildNotificationItem("martini_rond", "started following you.", "3d",
            textColor, subTextColor, tileColor,
            showButton: true),
        _buildNotificationItem("maxjacobson", "started following you.", "3d",
            textColor, subTextColor, tileColor,
            showButton: true),
        _buildNotificationItem("mis_potter", "started following you.", "3d",
            textColor, subTextColor, tileColor,
            showFollowButton: true),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String username,
    String action,
    String time,
    Color textColor,
    Color subTextColor,
    Color tileColor, {
    bool showImage = false,
    bool showButton = false,
    bool showFollowButton = false,
    bool showReply = false,
  }) {
    return Column(
      children: [
        ListTile(
          tileColor: tileColor,
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/dog2.png"),
          ),
          title: RichText(
            text: TextSpan(
              style: TextStyle(color: textColor, fontSize: 14),
              children: [
                TextSpan(
                    text: "$username ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: textColor)),
                TextSpan(text: action, style: TextStyle(color: textColor)),
              ],
            ),
          ),
          subtitle:
              Text(time, style: TextStyle(color: subTextColor, fontSize: 12)),
          trailing: showImage
              ? Image.asset("assets/images/dog2.png",
                  width: 40, height: 40, fit: BoxFit.cover)
              //Button to message
              : showButton
                  ? OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: tileColor,
                        side: const BorderSide(color: Colors.transparent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        minimumSize: const Size(90, 28),
                      ),
                      child: Text("Message",
                          style: TextStyle(color: textColor, fontSize: 13)),
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
                              child: Text("Reply",
                                  style: TextStyle(color: Colors.blue)),
                            )
                          : null,
        ),
      ],
    );
  }

  Widget _buildDivider(Color? dividerColor) {
    return Divider(color: dividerColor, thickness: 1);
  }
}
