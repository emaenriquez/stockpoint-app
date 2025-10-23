import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final authService = Provider.of<AuthService>(context, listen: false);
      final success = await authService.register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro exitoso. Ahora puede iniciar sesión.'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El correo electrónico ya existe'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                validator: (value) =>
                    value!.isEmpty ? 'Por favor ingrese su nombre de usuario' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Por favor ingrese una contraseña' : null,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirmar contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor confirme su contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _register,
                      child: const Text('Registrarse'),
                    ),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('¿Ya tiene una cuenta? Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}