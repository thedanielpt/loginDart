import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String nombre;
  String rol;

  User({
    required this.nombre,
    required this.rol
  });

  factory User.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return User(
      nombre: (data['nombre'] ?? '') as String,
      rol: (data['rol'] ?? '') as String,
    );
  }

  // Convertir de objeto a Firestore
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'rol': rol,
    };
  }
}
