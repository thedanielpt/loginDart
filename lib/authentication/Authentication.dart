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

  Future<bool> registrarUsuario(emailController, passwordController) async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      //Crea el usuario en auth
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = _auth.currentUser!.uid;

      await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
        'rol': "jugador",
        'nombre': "",
      });

      return true;

    } on FirebaseAuthException catch (e) {
      print('Error Firebase: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
}