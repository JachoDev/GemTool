import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';

class AddressField extends StatelessWidget {
  const AddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTicketBloc>().state;
    final hintText = state.initialTicket?.address ?? '';

    return TextFormField(
      key: const Key('editTodoView_address_textFormField'),
      initialValue: state.address,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Address',
        hintText: hintText,
      ),
      maxLength: 100,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9\s]'),
        ),
      ],
      onChanged: (value) {
        context.read<EditTicketBloc>().add(
          EditTicketAddressChanged(value),
        );
      },
    );
  }
}
