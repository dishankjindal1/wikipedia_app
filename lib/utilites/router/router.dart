import 'package:go_router/go_router.dart';
import 'package:wikipedia_app/presentation/screens/home/home_screen.dart';

class AppNavigation {
  final GoRouter routerConfig = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeScreen();
          }),
    ],
  );
}
