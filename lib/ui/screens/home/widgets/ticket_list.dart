import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:gemtool/bloc/bloc.dart';
import 'widgets.dart';

class TicketList extends StatelessWidget {
  const TicketList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketOverviewBloc, TicketOverviewState>(
      builder: (context, state) {
        if (state.tickets.isEmpty) {
          if (state.status == TicketOverviewStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.status != TicketOverviewStatus.success) {
            return const SizedBox();
          } else {
            return const Center(
              child: Text('Ticket container empty'),
            );
          }
        }

        return CupertinoScrollbar(
          child: ListView(
            children: [
              for (final ticket in state.filteredTickets)
                TicketListTile(
                  ticket: ticket,
                  onToggleCompleted: (isSelected) {
                    context.read<TicketOverviewBloc>().add(
                        TicketOverviewTicketCompletionToggled(
                          ticket: ticket,
                          isSelected: isSelected,
                        )
                    );
                  },
                  onDismissed: (_) {
                    context
                        .read<TicketOverviewBloc>()
                        .add(TicketOverviewTicketDeleted(ticket));
                  },
                  onTap: () {
                    context.go('/edit', extra: ticket);
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
