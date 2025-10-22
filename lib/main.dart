import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/config/app_routes.dart';
import 'package:myapp/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          final router = AppRoutes.getRouter(authService);
          return MaterialApp.router(
            routerConfig: router,
            title: 'Stock Point',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
