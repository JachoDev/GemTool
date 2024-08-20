import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';

class DatetimeField extends StatelessWidget {
  const DatetimeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTicketBloc>().state;
    final hintText = state.initialTicket?.dateTime ?? '';

    return TextFormField(
      key: const Key('editTodoView_datetime_textFormField'),
      initialValue: state.dateTime,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Datetime',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(
          RegExp(r'[/0-9\s]'),
        ),
      ],
      onChanged: (value) {
        context.read<EditTicketBloc>().add(
          EditTicketDateTimeChanged(value),
        );
      },
    );
  }
}
