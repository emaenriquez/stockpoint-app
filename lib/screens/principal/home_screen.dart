import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/mock_data_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              MockDataService.cerrarSesion();
              context.go('/login');
            },
          ),
        ],
      ),
      body: const Center(child: Text('¡Bienvenido a Stock Point!')),
    );
  }
}
