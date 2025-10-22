import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../config/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = usuarioActual;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Point'),
        actions: [
          IconButton(
            onPressed: () {
              MockDataService.cerrarSesion();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          user != null
              ? 'Bienvenido, ${user.nombre} (${user.rol})'
              : 'Sin sesión activa',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
