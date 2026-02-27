import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String nombre;
  final String rol;

  User({
    this.id,
    required this.nombre,
    required this.rol,
  });

  factory User.fromMap(Map<String, dynamic> data, {required String id}) {
    return User(
      id: id,
      nombre: (data['nombre'] ?? 'Sin nombre').toString(),
      rol: (data['rol'] ?? 'usuario').toString(),
    );
  }

  factory User.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return User.fromMap(data, id: doc.id);
  }

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'rol': rol,
  };
}