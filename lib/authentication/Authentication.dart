import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Variable para poder comunicarse con firebase
final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class Authentication {

  //Mandar email de restablecer la contraseña
  Future<bool> enviarEmailResetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print("Firebase error: ${e.code}");
      return false;
    }
  }


  Future<String?> iniciarSesion(email, contrasena) async {
    String rol = "";
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: contrasena.text,
      );
      final user = _auth.currentUser;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(user?.uid)
          .get();
      rol = doc.get("rol");
      if (rol != null) {
        return rol;
      }
    }catch (e) {
      print(e);
    }
    return null;
  }

  //Registra el email junto con su contraseña

  Future<void> registrarUsuario(emailController, passwordController) async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user!.uid;

      await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
        'nombre': 'Prueba',
        'rol': 'jugador',
      });

    } on FirebaseAuthException catch (e) {
      print('Auth error: ${e.code} - ${e.message}');
    } on FirebaseException catch (e) {
      print('Firestore error: ${e.code} - ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
  }
}