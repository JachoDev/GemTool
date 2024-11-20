import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';
import 'widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TicketOverviewBloc, TicketOverviewState>(
          listenWhen: (previous, current) =>
          previous.status != current.status,
          listener: (context, state) {
            if (state.status == TicketOverviewStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Error on ticket overview state')),
                );
            }
          },
        ),
        BlocListener<TicketOverviewBloc, TicketOverviewState>(
          listenWhen: (previous, current) =>
          previous.lastDeletedTicket != current.lastDeletedTicket &&
              current.lastDeletedTicket != null,
          listener: (context, state) {
            final deletedTicket = state.lastDeletedTicket!;
            final messenger = ScaffoldMessenger.of(context);
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  width: 50,
                    content: Text('Deleted "${deletedTicket.title}"'),
                    action: SnackBarAction(
                      label: 'Undo delete ticket',
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<TicketOverviewBloc>()
                            .add(const TicketOverviewUndoDeletionRequested());
                      },
                    )
                ),
              );
          },
        ),
      ],
      child: const TicketList(),
    );
  }
}

