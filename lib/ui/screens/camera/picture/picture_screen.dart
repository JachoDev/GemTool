import 'dart:io';

import 'package:flutter/material.dart';

class PictureScreen extends StatelessWidget {
  final String imagePath;

  const PictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picture')),
      backgroundColor: Colors.black,
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}