import 'package:camera/camera.dart';
import 'package:gemtool/main.dart';
import 'package:flutter/material.dart';
import 'package:gemtool/router/app_router.dart';
import 'package:gemtool/ui/screens/camera/camera_screen.dart';
import 'package:gemtool/ui/screens/home/home_screen.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'GemTool App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      routerConfig:AppRouter.router,
    );
  }
}
