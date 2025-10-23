import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Point'),
        automaticallyImplyLeading: false,
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(user.foto),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido a Stock Point!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (user != null) ...[
              const SizedBox(height: 20),
              Text(
                'Usuario: ${user.nombre}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Rol: ${user.rol}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
