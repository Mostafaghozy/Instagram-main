import 'package:flutter/material.dart';

class StoryListWidget extends StatelessWidget {
  final ScrollController controller; // ✅ تمرير الكنترولر لضبط الترتيب
  const StoryListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller, // ✅ استخدام الكنترولر هنا
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      separatorBuilder: (context, index) => const SizedBox(width: 15),
      itemBuilder: (context, index) {
        return StoryItem(index: index + 1); // ✅ نبدأ من 1 بدلاً من 0
      },
    );
  }
}

class StoryItem extends StatelessWidget {
  final int index;
  const StoryItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print('تم النقر على الاستوري: $index');
          },
          child: const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/dog4.png'),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Text$index", // ✅ يبدأ من Text1 بدلاً من Add
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
