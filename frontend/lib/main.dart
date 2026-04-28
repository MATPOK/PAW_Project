import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importujemy Twój nowy plik

void main() {
  runApp(const Pill4UApp());
}

class Pill4UApp extends StatelessWidget {
  const Pill4UApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PILL4U',
      debugShowCheckedModeBanner: false, // Wyłącza pasek DEBUG
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF000080)),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Ustawienie ekranu logowania jako startowego
    );
  }
}