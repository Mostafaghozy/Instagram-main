import 'dart:io';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final File imageFile;
  const FavoriteScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
