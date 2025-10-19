import 'package:flutter/material.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/recover_password_screen.dart';
import '../screens/auth/change_password_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const recover = '/recover';
  static const changePassword = '/change-password';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => SplashScreen(),
    login: (_) => LoginScreen(),
    register: (_) => RegisterScreen(),
    recover: (_) => RecoverPasswordScreen(),
    changePassword: (_) => ChangePasswordScreen(),
  };
}