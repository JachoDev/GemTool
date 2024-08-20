import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTicketBloc>().state;
    final hintText = state.initialTicket?.description ?? '';

    return TextFormField(
      key: const Key('editTodoView_description_textFormField'),
      initialValue: state.description,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Description',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9\s]'),
        ),
      ],
      onChanged: (value) {
        context.read<EditTicketBloc>().add(
          EditTicketDescriptionChanged(value),
        );
      },
    );
  }
}
