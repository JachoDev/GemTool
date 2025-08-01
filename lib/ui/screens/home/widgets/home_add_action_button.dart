import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:gemtool/bloc/bloc.dart';

class HomeAddActionButton extends StatelessWidget {
  const HomeAddActionButton({
    super.key,
  });

  Future<Uint8List?> getImage(
      ImageSource source,
      ) async {
      final ImagePicker _picker =  ImagePicker();

      if (_picker.supportsImageSource(ImageSource.camera)) {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
          );
          final imgbytes = await pickedFile?.openRead().first;

          return imgbytes;
        } catch (e) {
          return null;
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((TicketOverviewBloc bloc) => bloc.state.status);
    final _key = GlobalKey<ExpandableFabState>();

    Future<void> onButtonPressed(source) async {
      final imagePath = await getImage(source);
      final buttonState = _key.currentState;

      if ( buttonState != null ) {
        buttonState.toggle();
      }
      if ( imagePath != null ) {
        context.go('/ticket_generation', extra: imagePath);
      }
    }

    return BlocBuilder<TicketOverviewBloc, TicketOverviewState>(
      builder: (context, state) {
        return ExpandableFab(
          key: _key,
          pos: ExpandableFabPos.right,
          type: ExpandableFabType.up,
          overlayStyle: ExpandableFabOverlayStyle(
            color: Colors.black.withOpacity(0.5),
            blur: 5,
          ),
          children: [
            Row(
              children: [
                const Text('Create new table  '),
                FloatingActionButton.small(
                  tooltip: 'Table',
                  heroTag: null,
                  child: const Icon(Icons.table_chart),
                  onPressed: () {
                    final state = _key.currentState;
                    if ( state != null) {
                      state.toggle();
                    }

                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('New ticket with camera  '),
                FloatingActionButton.small(
                  tooltip: 'Camera',

                  heroTag: null,
                  child: const Icon(Icons.camera_alt),
                  onPressed: () => onButtonPressed(ImageSource.camera),
                ),
              ],
            ),
            Row(
              children: [
                const Text('New ticket from gallery   '),
                FloatingActionButton.small(
                  tooltip: 'Gallery',

                  heroTag: null,
                  child: const Icon(Icons.photo),
                  onPressed: () => onButtonPressed(ImageSource.gallery),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

