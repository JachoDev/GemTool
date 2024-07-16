import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gemtool/main.dart';

class FocusModeControlRow extends StatefulWidget {
  const FocusModeControlRow({
    super.key,
    required CameraController? controller,
    required Animation<double> focusModeControlRowAnimation
  }) : _controller = controller, _focusModeControlRowAnimation = focusModeControlRowAnimation;

  final CameraController? _controller;
  final Animation<double> _focusModeControlRowAnimation;

  @override
  _FocusModeControlRowState createState() => _FocusModeControlRowState();
}

class _FocusModeControlRowState extends State<FocusModeControlRow> {

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void onSetFocusModeButtonPressed(FocusMode mode) {
    setFocusMode(mode).then((_) {
      if (mounted) {
        setState(() {});
      }
      showInSnackBar('Focus mode set to ${mode.toString().split('.').last}');
    });
  }

  Future<void> setFocusMode(FocusMode mode) async {
    if (widget._controller == null) {
      return;
    }

    try {
      await widget._controller!.setFocusMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleAuto = TextButton.styleFrom(
      foregroundColor: widget._controller?.value.focusMode == FocusMode.auto
          ? Colors.orange
          : Colors.blue,
    );
    final ButtonStyle styleLocked = TextButton.styleFrom(
      foregroundColor: widget._controller?.value.focusMode == FocusMode.locked
          ? Colors.orange
          : Colors.blue,
    );

    return SizeTransition(
      sizeFactor: widget._focusModeControlRowAnimation,
      child: ClipRect(
        child: ColoredBox(
          color: Colors.grey.shade50,
          child: Column(
            children: <Widget>[
              const Center(
                child: Text('Focus Mode'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    style: styleAuto,
                    onPressed: widget._controller != null
                        ? () => onSetFocusModeButtonPressed(FocusMode.auto)
                        : null,
                    onLongPress: () {
                      if (widget._controller != null) {
                        widget._controller!.setFocusPoint(null);
                      }
                      showInSnackBar('Resetting focus point');
                    },
                    child: const Text('AUTO'),
                  ),
                  TextButton(
                    style: styleLocked,
                    onPressed: widget._controller != null
                        ? () => onSetFocusModeButtonPressed(FocusMode.locked)
                        : null,
                    child: const Text('LOCKED'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
