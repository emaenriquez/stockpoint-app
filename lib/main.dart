import 'package:flutter/material.dart';
import 'config/app_routes.dart';

void main() {
  runApp(const StockPointApp());
}

class StockPointApp extends StatelessWidget {
  const StockPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Point',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,

    );
  }
}
