import 'package:flutter/material.dart';
import '../../config/app_routes.dart';
import '../../data/mock_data.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String nueva = '', confirmar = '';

  bool get isComplete => nueva.isNotEmpty && confirmar.isNotEmpty;

  void _guardar() {
    if (nueva != confirmar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }
    final ok = MockDataService.cambiarContrasena(nueva);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña actualizada con éxito')),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar contraseña')),
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
              'Cambiar contraseña',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            buildTextField('Nueva contraseña', (v) => nueva = v),
            buildTextField('Confirmar contraseña', (v) => confirmar = v),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isComplete ? _guardar : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isComplete ? Colors.blue : Colors.grey,
              ),
              child: const Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: label),
        onChanged: (v) => setState(() => onChanged(v)),
      ),
    );
  }
}
