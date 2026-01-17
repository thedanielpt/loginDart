import 'package:firebase_auth/firebase_auth.dart';

//Variable para poder comunicarse con firebase
final FirebaseAuth _auth = FirebaseAuth.instance;

//Comprueba si el email que se intenta registrar ya esta registrado
Future<bool> existeUsuarioConEmail(email) async{

  final usuario = await _auth.fetchSignInMethodsForEmail(email);

  if (usuario.isNotEmpty) {
    return true;
  }

  return false;
}

//Registra el email junto con su contraseña

Future<bool> registrarUsuario(emailController, passwordController) async {
  try {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (await existeUsuarioConEmail(email)) {
      return false;
    }

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