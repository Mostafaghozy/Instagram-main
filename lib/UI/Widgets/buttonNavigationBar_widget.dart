import 'package:flutter/material.dart';
import 'package:instagram/UI/Screens/profileScreen.dart';
import 'package:instagram/UI/Screens/HomeScreen.dart';
import 'package:instagram/UI/Screens/ReelsScreen.dart';

class NavBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const NavBar(
      {super.key, required this.onItemSelected, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            navItem(Icons.home_filled, 0, context),
            navItem(Icons.search, 1, context),
            navItem(Icons.video_library, 2, context),
            navItem(Icons.shopping_bag_outlined, 3, context),
            profileIcon(4, context),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, int index, BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToScreen(index, context),
      child: Icon(
        icon,
        size: 30,
        color: selectedIndex == index ? Colors.black : Colors.black54,
      ),
    );
  }

  Widget profileIcon(int index, BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToScreen(index, context),
      child: CircleAvatar(
        radius: 14,
        backgroundColor:
            selectedIndex == index ? Colors.black : Colors.transparent,
        child: const CircleAvatar(
          radius: 12,
          backgroundImage: AssetImage("assets/images/dog2.png"),
        ),
      ),
    );
  }

  void _navigateToScreen(int index, BuildContext context) {
    Widget? screen;

    switch (index) {
      case 0:
        screen = const HomeScreen();
        break;
      case 1:
        // screen = const SearchScreen();
        break;
      case 2:
        screen = const ReelsScreen();
        break;
      case 3:
        // screen = const NotificationsScreen();
        break;
      case 4:
        // screen = const ProfileScreen();
        break;
    }

    if (screen != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen!),
      );
    }
  }
}
