import 'package:flutter/material.dart';
import 'package:gemtool/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_repository/tickets_repository.dart';

class App extends StatelessWidget {
  const App({required this.appRepository, super.key});

  final TicketsRepository appRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: appRepository,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'GemTool App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
