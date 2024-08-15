import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';

@visibleForTesting
enum TicketOverviewOption {toggleALl, clearSelected}

class TicketOverviewOptionsButton extends StatelessWidget {
  const TicketOverviewOptionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final tickets =
        context.select((TicketOverviewBloc bloc) => bloc.state.tickets);
    final hasTickets = tickets.isNotEmpty;
    final selectedTicketsAmount =
        tickets.where((ticket) => ticket.isSelected).length;

    return PopupMenuButton<TicketOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      tooltip: 'Options',
      onSelected: (options) {
        switch (options) {
          case TicketOverviewOption.toggleALl:
            context.read<TicketOverviewBloc>()
                .add(const TicketOverviewToggleAllRequested());

          case TicketOverviewOption.clearSelected:
            context.read<TicketOverviewBloc>()
                .add(const TicketOverviewClearSelectedRequested());
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TicketOverviewOption.toggleALl,
            enabled: hasTickets,
            child: Text(
              selectedTicketsAmount == tickets.length
                  ? 'Clear selection'
                  : 'Select all'
            ),
          ),
          PopupMenuItem(
            value: TicketOverviewOption.clearSelected,
            enabled: hasTickets && selectedTicketsAmount > 0,
            child: const Text('Delete selection'),
          ),
        ];
      },
    );
  }
}
