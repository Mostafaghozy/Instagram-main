import 'package:flutter/material.dart';

class GridviewWidget extends StatelessWidget {
  const GridviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image asset paths to show in the grid
    final List<String> imagePaths = [
      'assets/images/4443c524-5fa5-4d5f-ac57-50be919445b6.jpeg',
      'assets/images/dog2.png',
      'assets/images/dog3.png',
      'assets/images/9290a28d-c614-4482-9502-c394bd7fec8d.jpeg',
      'assets/images/366517d8-1152-4bd4-92bb-ee6be38f6b3b.jpeg',
      "assets/images/37983ce1-70c0-436e-a81a-70f236ac3026.jpeg",
      "assets/images/bb91c04d-806c-4211-bbbd-c239ba18ee7a.jpeg",
      "assets/images/3D Animation Style lofi style character of a young….jpeg",
      "assets/images/2102be83-8783-4f4a-b1d1-2a651078520b.jpeg",
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate item size to keep images square and proportional
        double gridWidth = constraints.maxWidth;
        int crossAxisCount = 3;
        double spacing = 4.0;
        double totalSpacing = (crossAxisCount - 1) * spacing;
        double itemWidth = (gridWidth - totalSpacing) / crossAxisCount;
        double itemHeight = itemWidth;
        return Center(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: itemWidth / itemHeight, // 1.0 for square
            ),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                    width: itemWidth,
                    height: itemHeight,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
