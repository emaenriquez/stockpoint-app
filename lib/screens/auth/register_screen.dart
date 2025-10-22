import 'package:flutter/material.dart';
import '../../config/app_routes.dart';
import '../../data/mock_data.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String nombre = '', correo = '', password = '', confirmPassword = '';

  bool get isComplete =>
      nombre.isNotEmpty &&
      correo.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  void _registrar() {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }
    final ok = MockDataService.registrar(nombre, correo, password);
    if (ok) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El correo ya está registrado')),
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
              'Registro',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            buildTextField('Nombre', 'Ingrese su nombre', (v) => nombre = v),
            buildTextField('Correo', 'Ingrese su correo', (v) => correo = v),
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
              onPressed: isComplete ? _registrar : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isComplete ? Colors.blue : Colors.grey,
              ),
              child: const Text('Registrarse'),
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
