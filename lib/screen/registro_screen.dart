import 'package:flutter/material.dart';
import '../validaciones/Validaciones.dart' as Validaciones;
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repeatPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width * 0.8;
    double altoPantalla = MediaQuery.of(context).size.height * 0.8;
    double espacio = altoPantalla * 0.05;

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
                const Text(
                  "Registro",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),

                SizedBox(height: espacio),

                CustomTextField(
                  controller: _email,
                  label: "Email",
                ),

                SizedBox(height: espacio),

                CustomTextField(
                  controller: _password,
                  label: "Contraseña",
                  obscure: true,
                ),

                SizedBox(height: espacio),

                CustomTextField(
                  controller: _repeatPassword,
                  label: "Repetir contraseña",
                  obscure: true,
                ),

                SizedBox(height: espacio),

                CustomButton(
                  text: "Registrarse",
                  onPressed: () async {

                    //Comprueba si el email o contraseña estan vacios
                    if (_email == "" || _password == "") {
                      return;
                    }

                    //Comprueba si las contraseñas coinciden
                    if (_password.text != _repeatPassword.text) {
                      return;
                    }

                    if (await Validaciones.registrarUsuario(_email, _password)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    }


                    Navigator.pop(context);
                  },
                ),

                SizedBox(height: espacio),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Volver al login",
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
