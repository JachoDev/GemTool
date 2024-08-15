import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_repository/tickets_repository.dart';

import 'router/app_router.dart';
import 'ui/theme/theme.dart';

class App extends StatelessWidget {
  const App({required this.ticketsRepository, super.key});

  final TicketsRepository ticketsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: ticketsRepository),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'GemTool App',
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
