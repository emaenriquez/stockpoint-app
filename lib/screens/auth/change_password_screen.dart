import 'package:flutter/material.dart';
import '../../config/app_routes.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String nueva = '', confirmar = '';

  bool get isComplete => nueva.isNotEmpty && confirmar.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            const Text(
              'Cambiar contraseña',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildTextField(
              'Nueva contraseña',
              'Ingrese nueva contraseña',
              (v) => nueva = v,
            ),
            buildTextField(
              'Confirmar contraseña',
              'Confirme su contraseña',
              (v) => confirmar = v,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isComplete ? Colors.blue : Colors.grey,
              ),
              onPressed: isComplete
                  ? () =>
                        Navigator.pushReplacementNamed(context, AppRoutes.login)
                  : null,
              child: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: label, hintText: hint),
        onChanged: (v) => setState(() => onChanged(v)),
      ),
    );
  }
}
