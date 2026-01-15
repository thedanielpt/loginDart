import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Controladores
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  // Datos correctos
  final String _emailUser = "daniel@gmail.com";
  final String _contrasenaUser = "1234";

  // Mensaje de error
  String error = "";

  @override
  Widget build(BuildContext context) {
    // Tamaño de pantalla
    double anchoPantalla = MediaQuery.of(context).size.width * 0.8;
    double altoPantalla = MediaQuery.of(context).size.height * 0.75;

    double espacioPantalla = altoPantalla * 0.06;
    double espacioLogo = altoPantalla * 0.1;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/rafa.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: anchoPantalla,
              height: altoPantalla,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A40).withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),

                  // Logo
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.17,
                    backgroundImage: const AssetImage('assets/logo.png'),
                  ),

                  SizedBox(height: espacioLogo),

                  // Email
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.white),
                      floatingLabelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: espacioPantalla),

                  // Contraseña
                  TextField(
                    controller: _contrasena,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(color: Colors.white),
                      floatingLabelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: espacioPantalla),

                  // Mensaje de error
                  if (error.isNotEmpty) ...[
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: espacioPantalla),
                  ],

                  // Botón login
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_email.text == _emailUser &&
                            _contrasena.text == _contrasenaUser) {
                          error = "Te has logueado";
                        } else {
                          error = "Email o contraseña incorrectos";
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C2C54),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 16),
                    ),
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
