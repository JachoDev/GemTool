import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';

class TotalField extends StatelessWidget {
  const TotalField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTicketBloc>().state;
    final hintText = state.initialTicket?.total.toStringAsFixed(2) ?? '00.00';

    return TextFormField(
      key: const Key('editTodoView_total_textFormField'),
      initialValue: state.total.toStringAsFixed(2),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Total',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9.\s]'),
        ),
      ],
      onChanged: (value) {
        context.read<EditTicketBloc>().add(
          EditTicketTotalChanged(double.parse(value)),
        );
      },
    );
  }
}
