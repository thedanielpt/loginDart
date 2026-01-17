import 'package:firebase_auth/firebase_auth.dart';

Future<void> registrarUsuario(emailController, passwordController) async {
  try {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      throw 'Email y contraseña obligatorios';
    }

    if (password.length < 6) {
      throw 'La contraseña debe tener al menos 6 caracteres';
    }

    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    print('Usuario registrado correctamente');

  } on FirebaseAuthException catch (e) {
    print('Error Firebase: ${e.message}');
  } catch (e) {
    print('Error: $e');
  }
}