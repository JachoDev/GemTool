import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gemtool/app.dart';
import 'package:gemtool/bootstrap.dart';
import 'package:local_storage_ticket_api/local_storage_ticket_api.dart';
import 'package:ticket_api/ticket_api.dart';

void logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

List<CameraDescription> cameras = <CameraDescription>[];

Future<void> main() async {
  BindingBase.debugZoneErrorsAreFatal = false;
  WidgetsFlutterBinding.ensureInitialized();

  final TicketApi ticketApi = LocalStorageTicketApi(
    plugin: await SharedPreferences.getInstance(),
  );

  try {
    cameras = await availableCameras();
  } on CameraException catch(e) {
    logError(e.code, e.description);
  }

  bootstrap(ticketApi: ticketApi);
}
