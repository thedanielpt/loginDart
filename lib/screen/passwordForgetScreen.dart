import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class passwordForgetScreen extends StatefulWidget {
  const passwordForgetScreen({super.key});

  @override
  State<passwordForgetScreen> createState() => _passwordForgetScreenState();
}

class _passwordForgetScreenState extends State<passwordForgetScreen> {
  final TextEditingController _email = TextEditingController();
  
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
                  SizedBox(height: espacio),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],

                SizedBox(height: espacio),

                CustomButton(
                    text: "Iniciar sesión",
                    onPressed: ()async {
                      //Comprueba has dejado en blanco algun dato
                      if (_email.text == "") {
                        setState(() {
                          error = "Falta poner el email";
                        });
                      }  
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}