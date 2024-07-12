import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gemtool/ui/screens/camera/camera_screen.dart';
import 'package:gemtool/ui/screens/camera/picture/picture_screen.dart';
import 'package:gemtool/ui/screens/camera/widgets/camera_view.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({
    super.key,
  });


  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<CameraDescription> setupCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    return camera;
  }

  @override
  void initState() {
    super.initState();
    final CameraDescription camera = setupCamera() as CameraDescription;
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Camera'),
      ),
      backgroundColor: Colors.black,
      body: CameraView(initializeControllerFuture: _initializeControllerFuture, controller: _controller),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

