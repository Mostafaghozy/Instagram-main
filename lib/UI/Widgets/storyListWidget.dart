import 'package:flutter/material.dart';

class StoryListWidget extends StatelessWidget {
  final ScrollController controller;
  const StoryListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemBuilder: (context, index) => StoryItem(index: index + 1),
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final int index;
  const StoryItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // List of story images to cycle through
    final List<String> storyImages = [
      'assets/images/dog4.png',
      'assets/images/dog2.png',
      'assets/images/dog3.png',
      'assets/images/4443c524-5fa5-4d5f-ac57-50be919445b6.jpeg',
      'assets/images/9290a28d-c614-4482-9502-c394bd7fec8d.jpeg',
      'assets/images/366517d8-1152-4bd4-92bb-ee6be38f6b3b.jpeg',
      'assets/images/37983ce1-70c0-436e-a81a-70f236ac3026.jpeg',
      'assets/images/bb91c04d-806c-4211-bbbd-c239ba18ee7a.jpeg',
      'assets/images/3D Animation Style lofi style character of a young….jpeg',
      'assets/images/2102be83-8783-4f4a-b1d1-2a651078520b.jpeg',
      'assets/images/pexels-jonathanborba-19431252.jpg',
      'assets/images/pexels-kqpho-1583582.jpg',
    ];
    final String imagePath = storyImages[(index - 1) % storyImages.length];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            // You can handle story tap here
          },
          child: Container(
            padding: const EdgeInsets.all(3), // thickness of outer circle
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.orange,
                  Colors.red,
                  Colors.yellow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Story $index',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ) ??
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
