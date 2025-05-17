import 'package:flutter/material.dart';
import 'package:instagram/UI/Widgets/Gridview_widget.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          indicatorColor: Colors.blue,
          tabs: [
            const Tab(icon: Icon(Icons.grid_on)),
            Tab(
                icon: Image.asset(
              "assets/icons/reels.png",
              width: 28,
              height: 28,
            )),
            const Tab(icon: Icon(Icons.person)),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: tabController,
            children: const [
              PhotosTab(),
              VideosTab(),
              ProfileTab(),
            ],
          ),
        ),
      ],
    );
  }
}

class PhotosTab extends StatelessWidget {
  const PhotosTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GridviewWidget(),
    );
  }
}

class VideosTab extends StatelessWidget {
  const VideosTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GridviewWidget(),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GridviewWidget(),
    );
  }
}
