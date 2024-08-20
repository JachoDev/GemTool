import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemtool/bloc/edit_ticket/edit_ticket_bloc.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTicketBloc>().state;
    final String stringBytes = state.initialTicket?.imageBytes ?? '';
    final List<int> list = stringBytes.codeUnits;
    final Uint8List bytes = Uint8List.fromList(list);

    return Image.memory(bytes);
  }
}
