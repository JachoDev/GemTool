import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:gemtool/app.dart';
import 'package:gemtool/app_bloc_observer.dart';
import 'package:local_storage_ticket_api/local_storage_ticket_api.dart';
import 'package:ticket_api/ticket_api.dart';
import 'package:tickets_repository/tickets_repository.dart';

void bootstrap({required TicketApi ticketApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final ticketRepository = TicketsRepository(ticketApi: ticketApi);

  runZonedGuarded(
    () => runApp(App(appRepository: ticketRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}