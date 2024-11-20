import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_storage_ticket_api/local_storage_ticket_api.dart';
import 'package:ticket_api/ticket_api.dart';

import 'bootstrap.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final TicketApi ticketApi = LocalStorageTicketApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(ticketApi: ticketApi);
}
