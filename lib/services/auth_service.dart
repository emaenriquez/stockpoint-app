import 'package:flutter/material.dart';
import 'package:myapp/data/mock_data_service.dart';
import 'package:myapp/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario? _user;

  Usuario? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<bool> login(String correo, String contrasena) async {
    final success = MockDataService.login(correo, contrasena);
    if (success) {
      _user = MockDataService.usuarioActual;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String nombre, String correo, String contrasena) async {
    final success = MockDataService.registrar(nombre, correo, contrasena);
    if (success) {
      // Don't set _user here - we want to redirect to login
      // Clear the current user after registration
      MockDataService.cerrarSesion();
      _user = null;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _user = null;
    MockDataService.cerrarSesion();
    notifyListeners();
  }

  Future<bool> changePassword(String nuevaContrasena) async {
    if (_user == null) return false;

    final success = MockDataService.cambiarContrasena(nuevaContrasena);
    if (success) {
      _user = MockDataService.usuarioActual;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> recoverPassword(String correo) async {
    try {
      final user = MockDataService.usuarios.firstWhere(
        (u) => u.correo == correo,
      );
      // For password recovery, we don't automatically log in the user
      // Just return true if the email exists
      return true;
    } catch (e) {
      return false;
    }
  }
}
