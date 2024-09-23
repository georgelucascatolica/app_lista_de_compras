// lib/main.dart
import 'package:flutter/material.dart';
import 'telas/tela_inicial.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Lista de Compras',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: const Color(0xFF000000),
          secondary: const Color(0xFFE1D772),
          tertiary: const Color(0xFFF06B50),
          surface: const Color(0xFFFAF4B1),
          background: const Color(0xFFFAF4B1),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: const Color(0xFFFAF4B1),
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: const Color(0xFFFAF4B1),
          brightness: Brightness.light,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF06B50), 
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF06B50),
          ),
        ),
      ),
      home: const TelaInicial(),
    );
  }
}
