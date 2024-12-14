import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/user_home_screen.dart'; // Asegúrate de tener esta clase importada
import 'screens/home_screen.dart'; // Aquí importas la pantalla de Admin como HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Aquí definimos las rutas
      initialRoute: '/login', // Página de inicio es LoginScreen
      routes: {
        '/login': (context) => const LoginScreen(), // Ruta para la pantalla de login
        '/userHome': (context) => const UserHomeScreen(), // Ruta para la pantalla de usuario
        '/adminHome': (context) => const HomeScreen(), // Ruta para la pantalla de Admin (HomeScreen)
      },
    );
  }
}
