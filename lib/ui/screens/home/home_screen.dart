import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemtool/bloc/ticket_overview/ticket_overview_bloc.dart';
import 'package:gemtool/ui/screens/home/widgets/home_view.dart';
import 'package:gemtool/ui/screens/home/widgets/ticket_list_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_api/ticket_api.dart';
import 'package:tickets_repository/tickets_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  String? _text = '';

  Future<void> _incrementCounter() async {
    const String response = 'This is the first resolution';

    setState(() {
      _counter++;
      _text = response;
    });
    //context.go('/camera');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      TicketOverviewBloc(
        ticketsRepository: context.read<TicketsRepository>(),
      )
        ..add(const TicketOverviewSubscriptionRequested()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text('Home'),
        ),
        floatingActionButton: BlocBuilder<TicketOverviewBloc, TicketOverviewState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () => context.read<TicketOverviewBloc>().add( TicketOverviewTicketCompletionToggled(ticket: Ticket(title: 'title'))),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          },
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<TicketOverviewBloc, TicketOverviewState>(
              listenWhen: (previous, current) =>
              previous.status != current.status,
              listener: (context, state) {
                if (state.status == TicketOverviewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('Error on ticket overview state')),
                    );
                }
              },
            )
          ],
          child: BlocBuilder<TicketOverviewBloc, TicketOverviewState>(
            builder: (context, state) {
              if (state.tickets.isEmpty) {
                if (state.status == TicketOverviewStatus.loading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state.status != TicketOverviewStatus.success) {
                  return const SizedBox();
                } else {
                  return Center(
                    child: Text('Ticket container empty \nCounter: $_counter'),
                  );
                }
              }

              return CupertinoScrollbar(
                child: ListView(
                  children: [
                    for (final ticket in state.filteredTickets)
                      TicketListTile(
                        ticket: ticket,
                        onToggleCompleted: (isCompleted) {
                          context.read<TicketOverviewBloc>().add(
                              TicketOverviewTicketCompletionToggled(
                                ticket: ticket,

                              )
                          );
                        },
                        onDismissed: (_) {
                          context
                              .read<TicketOverviewBloc>()
                              .add(TicketOverviewTicketDeleted(ticket));
                        },
                        onTap: () {
                          context.read<TicketOverviewBloc>().add( TicketOverviewTicketDeleted(state.tickets.last));
                        },
                      )
                  ],
                ),
              );
            },
          ),
        ),


      ),
    );
  }

  FloatingActionButton homeActionButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

}
