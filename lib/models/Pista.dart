import 'package:cloud_firestore/cloud_firestore.dart';

class Pista {
  
  final String id;

  final String nombre;

  const Pista({
    required this.id,
    required this.nombre,
  });

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
  };

  factory Pista.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Documento ${doc.id} sin datos');
    }

    return Pista(
      id: doc.id,
      nombre: data['nombre'] as String,
    );
  }
}