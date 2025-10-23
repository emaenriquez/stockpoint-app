import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screens/auth/change_password_screen.dart';
import 'package:myapp/screens/principal/home_screen.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/screens/auth/recover_password_screen.dart';
import 'package:myapp/screens/auth/register_screen.dart';
import 'package:myapp/screens/auth/splash_screen.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/screens/distribuidor/pedidos_recientes_screen.dart';
import 'package:myapp/screens/distribuidor/buscar_clientes_screen.dart';
import 'package:myapp/screens/distribuidor/buscar_productos_screen.dart';
import 'package:myapp/screens/distribuidor/productos_agregados_screen.dart';
import 'package:myapp/screens/distribuidor/resumen_pedido_screen.dart';

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
        // Rutas del distribuidor
        GoRoute(
          path: '/distribuidor/pedidos-recientes',
          builder: (context, state) => const PedidosRecientesScreen(),
        ),
        GoRoute(
          path: '/distribuidor/buscar-clientes',
          builder: (context, state) => const BuscarClientesScreen(),
        ),
        GoRoute(
          path: '/distribuidor/buscar-productos',
          builder: (context, state) => const BuscarProductosScreen(),
        ),
        GoRoute(
          path: '/distribuidor/productos-agregados',
          builder: (context, state) => const ProductosAgregadosScreen(),
        ),
        GoRoute(
          path: '/distribuidor/resumen-pedido',
          builder: (context, state) => const ResumenPedidoScreen(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final bool isAuthenticated = authService.isAuthenticated;
        final bool isAuthRoute = state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/recover-password' ||
            state.matchedLocation == '/change-password';

        if (!isAuthenticated && !isAuthRoute && state.matchedLocation != '/') {
          return '/login';
        }

        if (isAuthenticated && isAuthRoute) {
          // Redirect based on user role
          final user = authService.user;
          if (user != null && user.rol == 'distribuidor') {
            return '/distribuidor/pedidos-recientes';
          } else {
            return '/home';
          }
        }

        return null;
      },
    );
  }
}
