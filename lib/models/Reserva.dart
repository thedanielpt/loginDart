import 'package:cloud_firestore/cloud_firestore.dart';

class Reserva {
  final String id;
  final String usuarioId;
  final String pistaId;
  final String fecha; 
  final String hora;  

  const Reserva({
    required this.id,
    required this.usuarioId,
    required this.pistaId,
    required this.fecha,
    required this.hora,
  });

  factory Reserva.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Reserva(
      id: doc.id,
      usuarioId: data['usuarioId'],
      pistaId: data['pistaId'],
      fecha: data['fecha'],
      hora: data['hora'],
    );
  }

  Map<String, dynamic> toMap() => {
    'usuarioId': usuarioId,
    'pistaId': pistaId,
    'fecha': fecha,
    'hora': hora,
  };
}