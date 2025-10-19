import 'package:flutter/material.dart';
import '../../config/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '', correo = '', password = '', confirmPassword = '';

  bool get isComplete =>
      nombre.isNotEmpty &&
      correo.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Registro',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTextField(
                    'Nombre',
                    'Ingrese su nombre',
                    (v) => nombre = v,
                  ),
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
                  buildTextField(
                    'Confirmar contraseña',
                    'Confirme su contraseña',
                    (v) => confirmPassword = v,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isComplete ? Colors.blue : Colors.grey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                    onPressed: isComplete
                        ? () => Navigator.pushNamed(context, AppRoutes.login)
                        : null,
                    child: const Text('Registrarse'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                    child: const Text(
                      '¿Ya tienes cuenta? Inicia sesión',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
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
        obscureText: isPassword,
        decoration: InputDecoration(labelText: label, hintText: hint),
        onChanged: (v) => setState(() => onChanged(v)),
      ),
    );
  }
}
