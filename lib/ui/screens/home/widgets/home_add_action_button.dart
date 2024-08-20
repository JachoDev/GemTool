import 'dart:convert';
import 'dart:math';
//import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemtool/data/providers/genai_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_api/ticket_api.dart';

import 'package:gemtool/bloc/bloc.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality, int? limit);

class HomeAddActionButton extends StatelessWidget {
  const HomeAddActionButton({
    super.key,
  });



  Future<List<String?>> generateTicket(XFile file) async {
    final GenaiProvider genaiProvider = GenaiProvider();
    final  ticketGenerated = await genaiProvider.sendPrompt(file);

    return ticketGenerated;
  }

  Future<XFile?> getImage(
      ImageSource source
      ) async {
    final ImagePicker _picker = ImagePicker();

      if (_picker.supportsImageSource(ImageSource.camera)){
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
          );
          final imgbytes = await pickedFile?.openRead().first;

          return pickedFile;
        } catch (e) {
          return null;
        }
      }
  }



  @override
  Widget build(BuildContext context) {
    final status =
        context.select((TicketOverviewBloc bloc) => bloc.state.status);

    return BlocBuilder<TicketOverviewBloc, TicketOverviewState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: !status.isLoadingOrSuccess
            ? null
            : () async {

            final imagePath = await getImage(ImageSource.camera);
            final List<String?> ticketGenerated = await generateTicket(imagePath!);
            final newTicket = json.decode(ticketGenerated[0]!)[0];
            final ticket = Ticket.fromJson(newTicket);
            final finalTicket = ticket.copyWith(imageBytes: ticketGenerated[1]);

            context.go('/edit', extra: finalTicket);
          },
          tooltip: 'Increment',
          child: !status.isLoadingOrSuccess
              ? const CupertinoActivityIndicator()
              : const Icon(Icons.add),
        );
      },
    );
  }
}

