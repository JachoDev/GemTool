import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemtool/bloc/bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets.dart';

class EditTicketView extends StatelessWidget {
  const EditTicketView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTicketBloc, EditTicketState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          current.status == EditTicketStatus.success,
      listener: (context, state) {
        context.go('/');
      },
      child: const CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TitleField(),
                DescriptionField(),
                NameField(),
                PhoneField(),
                AddressField(),
                DatetimeField(),
                SubtotalField(),
                TaxesField(),
                TotalField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
