import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gemtool/ui/screens/camera/widgets/camera_app_preview.dart';
import 'package:gemtool/ui/screens/camera/widgets/camera_toggles_row.dart';
import 'package:gemtool/ui/screens/camera/widgets/capture_control_row.dart';
import 'package:gemtool/ui/screens/camera/widgets/mode_control_row.dart';

class CameraView extends StatefulWidget {
  CameraView({
    super.key,
    required CameraController? controller,
  }) : controller = controller;

  CameraController? controller;
  @override
  _CameraViewState createState() => _CameraViewState();
}
class _CameraViewState extends State<CameraView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color:
                widget.controller != null && widget.controller!.value.isRecordingVideo
                    ? Colors.redAccent
                    : Colors.grey,
                width: 3.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: CameraAppPreview(controller: widget.controller),
              ),
            ),
          ),
        ),
        CaptureControlRow(controller: widget.controller),
        ModeControlRow(controller: widget.controller),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              CameraTogglesRow(controller: widget.controller),
              //_thumbnailWidget(),
            ],
          ),
        ),
      ],
    );
  }

}




