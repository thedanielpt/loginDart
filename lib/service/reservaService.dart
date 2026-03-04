import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Reserva.dart';

class ReservaService {
  final _ref = FirebaseFirestore.instance.collection('reservas');

  Stream<List<Reserva>> listarReservas() {
    Query<Map<String, dynamic>> query = _ref;

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => Reserva.fromDoc(doc)).toList(),
    );
  }

  Stream<List<Reserva>> listarReservasJugador(String usuarioId) {
    Query<Map<String, dynamic>> query =
    _ref.where('usuarioId', isEqualTo: usuarioId);

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => Reserva.fromDoc(doc)).toList(),
    );
  }

  Future<Reserva?> cogerReservaById(String id) async {
    final doc = await _ref.doc(id).get();
    if (!doc.exists) return null;
    return Reserva.fromDoc(doc);
  }

  Future<bool> existeReserva({
    required String pistaId,
    required String fecha,
    required String hora,
  }) async {
    final q = await _ref
        .where('pistaId', isEqualTo: pistaId)
        .where('fecha', isEqualTo: fecha)
        .where('hora', isEqualTo: hora)
        .limit(1)
        .get();

    return q.docs.isNotEmpty;
  }

  
  Future<void> crearReservaSeguro(
      String usuarioId,
      String pistaId,
      String fecha,
      String hora,
      ) async {
    final ok = !(await existeReserva(pistaId: pistaId, fecha: fecha, hora: hora));
    if (!ok) {
      throw Exception("Ese horario ya está reservado.");
    }

    await _ref.add({
      'usuarioId': usuarioId,
      'pistaId': pistaId,
      'fecha': fecha,
      'hora': hora,
    });
  }

  Future<void> deleteReserva(String id) async {
    await _ref.doc(id).delete();
  }
}