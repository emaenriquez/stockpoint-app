import 'package:flutter/material.dart';
import 'package:myapp/data/mock_data.dart';
import 'package:myapp/models/usuario.dart';

class MockDataService {
  static List<Usuario> usuarios = [
    Usuario(
      id: 1,
      nombre: 'Juan Pérez',
      correo: 'juan@mail.com',
      contrasena: '1234',
      rol: 'distribuidor',
      foto: 'assets/avatar_distribuidor.png',
    ),
    // más usuarios...
  ];

  static Usuario? usuarioActual;

  static void cerrarSesion() {
    usuarioActual = null;
  }

  static bool cambiarContrasena(String nuevaContrasena) {
    if (usuarioActual != null) {
      usuarioActual!.contrasena = nuevaContrasena;
      return true;
    }
    return false;
  }
}

class AuthService with ChangeNotifier {
  Usuario? _user;

  Usuario? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<bool> login(String correo, String contrasena) async {
    try {
      final user = MockDataService.usuarios.firstWhere(
        (u) => u.correo == correo && u.contrasena == contrasena,
      );
      _user = user;
      MockDataService.usuarioActual = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String nombre, String correo, String contrasena) async {
    // Validar si ya existe el usuario
    if (MockDataService.usuarios.any((u) => u.correo == correo)) {
      return false;
    }

    final nuevo = Usuario(
      id: MockDataService.usuarios.length + 1,
      nombre: nombre,
      correo: correo,
      contrasena: contrasena,
      rol: 'distribuidor',
      foto: 'assets/avatar_distribuidor.png',
    );

    MockDataService.usuarios.add(nuevo);
    _user = nuevo;
    MockDataService.usuarioActual = nuevo;
    notifyListeners();
    return true;
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
      _user = user;
      MockDataService.usuarioActual = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
