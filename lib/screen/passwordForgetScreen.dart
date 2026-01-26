import 'package:flutter/material.dart';
import 'loginScreen.dart';
import '../authentication/Authentication.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class PasswordForgetScreen extends StatefulWidget {
  const PasswordForgetScreen({super.key});

  @override
  State<PasswordForgetScreen> createState() => _PasswordForgetScreenState();
}

class _PasswordForgetScreenState extends State<PasswordForgetScreen> {
  final TextEditingController _email = TextEditingController();
  
  String error = "";

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width * 0.8;
    double altoPantalla = MediaQuery.of(context).size.height * 0.75;
    double espacio = altoPantalla * 0.06;

    final Authentication _authentication = Authentication();



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

                const Text(
                  "Pon el email de tu usuario",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: espacio),

                CustomTextField(
                  controller: _email,
                  label: "Email",
                ),

                SizedBox(height: espacio),

                if (error  != "") ...[
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],

                SizedBox(height: espacio),

                CustomButton(
                  text: "Enviar email",
                  onPressed: ()async {
                    if (_email.text == "") {
                      setState(() {
                        error = "Falta poner el email";
                      });
                      return;
                    }
                    if (await _authentication.enviarEmailResetPassword(_email.text.trim())){
                      Navigator.pushNamed(context, "/");
                    } else {
                      setState(() {
                        error = "Email incorrecto";
                      });
                    }
                  }
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
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