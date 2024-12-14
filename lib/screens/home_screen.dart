import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Admin'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'salir') {
                // Redirige al login cuando se seleccione "Salir"
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            color: Colors.deepPurple, // Color de fondo del PopupMenuButton
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 2), // Borde blanco alrededor del submenú
              borderRadius: BorderRadius.circular(4), // Bordes redondeados
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'salir',
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app, color: Colors.white), // Ícono blanco
                      SizedBox(width: 8),
                      Text(
                        'Salir',
                        style: TextStyle(color: Colors.white), // Texto blanco
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Bienvenido Admin',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
