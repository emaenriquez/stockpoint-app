import 'package:flutter/material.dart';
import '../../config/app_routes.dart';
import '../../data/mock_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String correo = '', password = '';

  bool get isComplete => correo.isNotEmpty && password.isNotEmpty;

  void _login() {
    final ok = MockDataService.login(correo, password);
    if (ok) {
      Navigator.pushReplacementNamed(context, AppRoutes.changePassword);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            const Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildTextField(
              'Correo electrónico',
              'Ingrese su correo',
              (v) => correo = v,
            ),
            buildTextField(
              'Contraseña',
              'Ingrese su contraseña',
              (v) => password = v,
              isPassword: true,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isComplete ? Colors.blue : Colors.grey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              onPressed: isComplete ? _login : null,
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.register),
              child: const Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    String hint,
    Function(String) onChanged, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onChanged: (v) => setState(() => onChanged(v)),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        obscureText: isPassword,
      ),
    );
  }
}
