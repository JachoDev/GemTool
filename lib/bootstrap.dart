import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_api/ticket_api.dart';
import 'package:tickets_repository/tickets_repository.dart';

import 'app.dart';
import 'app_bloc_observer.dart';

void bootstrap({required TicketApi ticketApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final ticketRepository = TicketsRepository(ticketApi: ticketApi);

  runZonedGuarded(
    () => runApp(App(ticketsRepository: ticketRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}