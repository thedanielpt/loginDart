import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> registrarUsuario(emailController, passwordController) async {
  try {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (password.length < 6) {
      throw 'La contraseña debe tener al menos 6 caracteres';
    }

    // 🔹 COMPROBAR SI EL EMAIL YA EXISTE
    final methods =
    await _auth.fetchSignInMethodsForEmail(email);

    if (methods.isNotEmpty) {
      throw 'Este correo ya está registrado';
    }

    // 🔥 REGISTRO EN FIREBASE
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
