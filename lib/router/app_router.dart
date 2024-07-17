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
          },
          routes: [
            GoRoute(
              path: 'camera',
              builder: (context, state){
                return const CameraScreen();
              },
            ),
          ]
        ),

      ]
  );

  static GoRouter get router => _router;
}