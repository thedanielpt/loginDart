import 'package:flutter/material.dart';
import '../authentication/Authentication.dart';
import '../widgets/login/custom_textfield.dart';
import '../widgets/login/custom_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  final Authentication _authentication = Authentication();

  String error = "";

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width * 0.8;
    double altoPantalla = MediaQuery.of(context).size.height * 0.78;
    double espacio = altoPantalla * 0.04;

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



                if (error.isNotEmpty) ...[
                  SizedBox(height: 20),
                  Text(
                    error,
                    style: TextStyle(
                      color: error == "Has iniciado sesión" ? Colors.green : Colors.red,
                    ),
                  ),
                ],
                SizedBox(height: espacio),

                CustomButton(
                  text: "Iniciar sesión",
                  onPressed: ()async {

                    //Comprueba has dejado en blanco algun dato
                    if (_email.text == "" || _contrasena.text == "") {
                      setState(() {
                        error = "Falta poner el email o contraseña";
                      });
                      return;
                    }

                    //Comprueba si el usuario existe
                    if (await _authentication.iniciarSesion(_email, _contrasena)){
                      setState(() {
                        Navigator.pushNamed(context, "/admin");
                      });
                    } else {
                      setState(() {
                        error = "Email o contraseña incorrectos";
                      });
                    }
                  }
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/registro");
                  },
                  child: const Text(
                    "¿No tienes cuenta? Regístrate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/passwordForgetScreen");
                  },
                  child: const Text(
                    "¿Te has olvidado de tu contraseña?",
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