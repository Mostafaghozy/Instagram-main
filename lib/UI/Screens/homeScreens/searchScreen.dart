import 'package:flutter/material.dart';
import 'package:instagram/UI/Widgets/Gridview_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Back arrow button
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new,
                      color: isDark ? Colors.white : Colors.black),
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                  tooltip: 'Back',
                ),
                const SizedBox(width: 4),
                // Expanded search bar
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black),
                      cursorColor: isDark ? Colors.white : Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            color: isDark ? Colors.white54 : Colors.black54),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: isDark ? Colors.white54 : Colors.black54),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.tune,
                        color: isDark ? Colors.white54 : Colors.black54),
                    onPressed: () {},
                    tooltip: 'Filter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Text(
                'Explore',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Expanded(
              child: const GridviewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
