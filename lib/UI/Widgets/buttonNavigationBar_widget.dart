import 'package:flutter/material.dart';
import 'package:instagram/UI/Screens/homeScreens/profileScreen.dart';
import 'package:instagram/UI/Screens/homeScreens/HomeScreen.dart';
import 'package:instagram/UI/Screens/homeScreens/ReelsScreen.dart';
import 'package:instagram/UI/Screens/homeScreens/searchScreen.dart';

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Widget displayIconWidget;
    // Change icons for dark mode
    if (index == 2) {
      // Use custom asset for reels icon
      displayIconWidget = Image.asset(
        'assets/icons/reels.png',
        width: 30,
        height: 30,
        color: isDarkMode
            ? Colors.white
            : (selectedIndex == index ? Colors.black : Colors.black54),
      );
    } else {
      IconData displayIcon = icon;
      if (isDarkMode) {
        switch (index) {
          case 0:
            displayIcon = Icons.home_filled;
            break;
          case 1:
            displayIcon = Icons.search;
            break;
          case 3:
            displayIcon = Icons.shopping_bag_outlined;
            break;
        }
      }
      displayIconWidget = Icon(
        displayIcon,
        size: 30,
        color: isDarkMode
            ? Colors.white
            : (selectedIndex == index ? Colors.black : Colors.black54),
      );
    }
    return GestureDetector(
      onTap: () => _navigateToScreen(index, context),
      child: displayIconWidget,
    );
  }

  Widget profileIcon(int index, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => _navigateToScreen(index, context),
      child: CircleAvatar(
        radius: 14,
        backgroundColor: selectedIndex == index
            ? (isDarkMode ? Colors.white : Colors.black)
            : Colors.transparent,
        child: const CircleAvatar(
          radius: 12,
          backgroundImage: const AssetImage("assets/images/dog2.png"),
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
        screen = const SearchScreen();
        break;
      case 2:
        screen = const ReelsScreen();
        break;
      case 3:
        // screen = const NotificationsScreen();
        break;
      case 4:
        screen = const ProfileScreen();
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
