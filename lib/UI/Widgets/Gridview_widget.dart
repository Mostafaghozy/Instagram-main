import 'package:flutter/material.dart';

class GridviewWidget extends StatelessWidget {
  const GridviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.black12,
            child: Center(
              child: Image.asset(
                "assets/images/dog4.png",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
