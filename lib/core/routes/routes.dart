import 'package:free_health_camp/features/auth/presentation/screens/login_screen.dart';
import 'package:free_health_camp/features/auth/presentation/screens/registration_screen.dart';
import 'package:free_health_camp/features/splash/presentation/screens/splash_screen.dart';
import 'package:free_health_camp/features/todo/presentation/screens/todo_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

enum AppRoute {
  splash,
  login,
  registration,
  todo
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/registration',
        name: AppRoute.registration.name,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: '/todo',
        name: AppRoute.todo.name,
        builder: (context, state) => const TodoScreen(),
      ),
    ],
  );
}
