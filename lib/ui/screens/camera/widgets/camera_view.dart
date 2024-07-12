import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({
    super.key,
    required Future<void> initializeControllerFuture,
    required CameraController controller,
  }) : _initializeControllerFuture = initializeControllerFuture, _controller = controller;

  final Future<void> _initializeControllerFuture;
  final CameraController _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
              child: CameraPreview(_controller));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
