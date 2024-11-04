import 'package:flutter/material.dart';
import 'package:frontend/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Aplikasi',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
