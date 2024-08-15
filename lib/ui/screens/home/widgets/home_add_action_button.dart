import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_api/ticket_api.dart';

import 'package:gemtool/bloc/bloc.dart';

class HomeAddActionButton extends StatelessWidget {
  const HomeAddActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketOverviewBloc, TicketOverviewState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () =>
              context.read<TicketOverviewBloc>()
                  .add( TicketOverviewTicketCompletionToggled(
                ticket: Ticket(
                  title: 'title',
                  description: 'description',
                  name: 'oxxo',
                ),
                isSelected: false,
              )),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      },
    );
  }
}

