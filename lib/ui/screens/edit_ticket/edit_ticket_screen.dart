import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';
import 'widgets/widgets.dart';

class EditTicketScreen extends StatelessWidget {
  const EditTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isNewTicket = context.select(
          (EditTicketBloc bloc) => bloc.state.isNewTicket,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            isNewTicket
                ? 'Add ticket'
                : 'Edit ticket'
          ),
        ),
        floatingActionButton: const EditTicketSaveActionButton(),
        body: const EditTicketView(),
      );
  }
}




