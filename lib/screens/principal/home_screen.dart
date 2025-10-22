import 'package:flutter/material.dart';
import 'package:stockpoint_app/data/mock_data_service.dart';
import 'package:stockpoint_app/config/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Point'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              MockDataService.usuarioActual = null;
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('¡Bienvenido a Stock Point!'),
      ),
    );
  }
}