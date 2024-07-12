import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gemtool/ui/screens/camera/camera_screen.dart';
import 'package:gemtool/ui/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

 class AppRouter{
  static final GoRouter _router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: 'home',
          builder: ( context, state){
            return const HomeScreen();
          }
        ),
        GoRoute(
          path: '/camera',
          name: 'camera',
          builder: (context, state){
            return CameraScreen();
          },
        ),
      ]
  );

  static GoRouter get router => _router;
}