import 'package:firebase_auth/firebase_auth.dart' as auth; // Alias para evitar conflictos
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/User.dart';

class Authentication {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<User?> iniciarSesion(TextEditingController email, TextEditingController contrasena) async {
    try {
      // 1. Usamos el alias 'auth' para la credencial
      auth.UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: contrasena.text.trim(),
      );

      final String? uid = credential.user?.uid;

      if (uid != null) {
        // 2. Obtenemos el documento de Firestore
        DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
            .collection("usuarios")
            .doc(uid)
            .get();
        if (doc.exists) {
          // 3. Ahora 'User' se refiere a tu modelo y encontrará 'fromDoc'
          return User.fromDoc(doc);
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  //Mandar email de restablecer la contraseña
  Future<bool> enviarEmailResetPassword(String email) async {
    try {
      await auth.FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );
      return true;
    } on auth.FirebaseAuthException catch (e) {
      print("Firebase error: ${e.code}");
      return false;
    }
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
        'email': email,
      });

    } on auth.FirebaseAuthException catch (e) {
      print('Auth error: ${e.code} - ${e.message}');
    } on FirebaseException catch (e) {
      print('Firestore error: ${e.code} - ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
  }
}