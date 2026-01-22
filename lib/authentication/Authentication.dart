import 'package:firebase_auth/firebase_auth.dart';

//Variable para poder comunicarse con firebase
final FirebaseAuth _auth = FirebaseAuth.instance;

class Authentication {

  Future<bool> iniciarSesion(email, contrasena) async {

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: contrasena.text,
      );
      return true;
    }catch (e) {
      print(e);
    }

    return false;
  }

  //Registra el email junto con su contraseña

  Future<bool> registrarUsuario(emailController, passwordController) async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;

    } on FirebaseAuthException catch (e) {
      print('Error Firebase: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
}