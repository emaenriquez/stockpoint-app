import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screens/auth/change_password_screen.dart';
import 'package:myapp/screens/auth/home_screen.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/screens/auth/recover_password_screen.dart';
import 'package:myapp/screens/auth/register_screen.dart';
import 'package:myapp/screens/auth/splash_screen.dart';
import 'package:myapp/services/auth_service.dart';

class AppRoutes {
  static GoRouter getRouter(AuthService authService) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: authService,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/recover-password',
          builder: (context, state) => const RecoverPasswordScreen(),
        ),
        GoRoute(
          path: '/change-password',
          builder: (context, state) => const ChangePasswordScreen(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final bool isAuthenticated = authService.isAuthenticated;
        final bool isAuthRoute = state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/recover-password' ||
            state.matchedLocation == '/change-password';

        if (!isAuthenticated && !isAuthRoute) {
          return '/';
        }

        if (isAuthenticated && isAuthRoute) {
          return '/home';
        }

        return null;
      },
    );
  }
}
