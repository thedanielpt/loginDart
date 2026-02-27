import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String nombre;
  final String rol;
  final String email;

  User({
    this.id,
    required this.nombre,
    required this.rol,
    required this.email,
  });

  factory User.fromMap(Map<String, dynamic> data, {required String id}) {
    return User(
      id: id,
      nombre: (data['nombre'] ?? 'Sin nombre').toString(),
      rol: (data['rol'] ?? 'usuario').toString(),
      email: (data['email'] ?? '').toString(),
    );
  }

  factory User.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return User.fromMap(data, id: doc.id);
  }

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'rol': rol,
    'email': email,
  };
}