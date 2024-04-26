import 'package:go_router/go_router.dart';

import '../screens/client/login.dart';
import '../screens/core/error.dart';
import '../screens/core/loader.dart';
import '../screens/home.dart';
import '../screens/static/boarding.dart';

void main() {}
// GoRouter configuration
final routes = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoaderScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
    ),
  ],
);
