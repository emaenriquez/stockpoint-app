import 'package:flutter/material.dart';
import '../../config/app_routes.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  String correo = '';

  bool get isComplete => correo.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Recuperar contraseña',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              'Ingresa tu correo electrónico para recibir las instrucciones de recuperación.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'Ingrese su correo electrónico',
              ),
              onChanged: (v) => setState(() => correo = v),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isComplete ? Colors.blue : Colors.grey,
              ),
              onPressed: isComplete
                  ? () => Navigator.pushNamed(context, AppRoutes.changePassword)
                  : null,
              child: const Text('Recuperar contraseña'),
            )
          ],
        ),
      ),
    );
  }
}
