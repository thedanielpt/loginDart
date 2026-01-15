import 'dart:collection';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    //VARIABLES FRONT

    //Sirve para medir el ancho y lo alto de la pantalla
    double anchoPantalla = MediaQuery.of(context).size.width;
    double altoPantalla = MediaQuery.of(context).size.height;
    //Calculo del tamaño del ancho y alto de la pantalla
    anchoPantalla = anchoPantalla * 0.8;
    altoPantalla = altoPantalla * 0.75;

    //Variables para el login
    TextEditingController _email = TextEditingController();
    TextEditingController _contrasena = TextEditingController();
    String _emailUser = "daniel@gmail.com";
    String _contrasenaUser = "1234";

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Container(
        // Imagen de fondo
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/rafa.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: Center(
            //Rectangulo del fondo
            child: Container(
              width: anchoPantalla,
              height: altoPantalla,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A40).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Imagen del logo
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.20,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),

                  const SizedBox(height: 40),

                  TextField(
                    controller: _email, // Asociar el controlador
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
