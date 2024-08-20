import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tickets_repository/tickets_repository.dart';

import '../ui/screens/screens.dart';
import '../bloc/bloc.dart';

 class AppRouter{
  static final GoRouter _router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: 'home',
          builder: ( context, state) => BlocProvider(
            create: (context) => TicketOverviewBloc(
              ticketsRepository: context.read<TicketsRepository>(),
            )..add(const TicketOverviewSubscriptionRequested()),
            child: const HomeScreen(),
          ),
          routes: [
            GoRoute(
              path: 'edit',
              builder: (context, state) {
                Ticket? initialTicket = state.extra as Ticket;
                return BlocProvider(
                    create: (context) => EditTicketBloc(
                  ticketsRepository: context.read<TicketsRepository>(),
                  initialTicket: initialTicket,
                ),
                child: const EditTicketScreen()
                );
              }
            ),
          ]
        ),
      ]
  );

  static GoRouter get router => _router;
}