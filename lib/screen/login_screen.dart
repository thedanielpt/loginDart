import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import 'registro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  String error = "";

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width * 0.8;
    double altoPantalla = MediaQuery.of(context).size.height * 0.75;
    double espacio = altoPantalla * 0.06;

    return Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),

                SizedBox(height: espacio),

                CustomTextField(
                  controller: _email,
                  label: "Email",
                ),

                SizedBox(height: espacio),

                CustomTextField(
                  controller: _contrasena,
                  label: "Contraseña",
                  obscure: true,
                ),

                SizedBox(height: espacio),

                Text(error, style: const TextStyle(color: Colors.red),),

                SizedBox(height: espacio),

                CustomButton(
                  text: "Iniciar sesión",
                  onPressed: ()async {
                      if (_email.text == "" && _contrasena.text == "") {
                        setState(() {
                          error = "Tienes que poner tu usuario y contraseña";
                        });
                      } else {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _email.text,
                            password: _contrasena.text,
                          );
                          setState(() {
                            error = "Te has logueado";
                          });
                        }catch (e) {
                          setState(() {
                            error = "Email o contraseña incorrectos";
                          });
                        }
                      }
                  },
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegistroScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "¿No tienes cuenta? Regístrate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
