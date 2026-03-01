import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Reserva.dart';

class ReservaService {
  final _ref = FirebaseFirestore.instance.collection('reservas');

  Stream<List<Reserva>> listarReservas({String? fecha}) {
    Query<Map<String, dynamic>> query = _ref;

    if (fecha != null && fecha.isNotEmpty) {
      query = query.where('fecha', isEqualTo: fecha);
    }

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => Reserva.fromDoc(doc)).toList(),
    );
  }

  Stream<List<Reserva>> listarReservasJugador(String usuarioId, {String? fecha}) {
    Query<Map<String, dynamic>> query =
    _ref.where('usuarioId', isEqualTo: usuarioId);

    if (fecha != null && fecha.isNotEmpty) {
      query = query.where('fecha', isEqualTo: fecha);
    }

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => Reserva.fromDoc(doc)).toList(),
    );
  }

  Stream<List<Reserva>> listarReservasRango({
    required String fechaInicio, // yyyy-MM-dd
    required String fechaFin,    // yyyy-MM-dd
  }) {
    final query = _ref
        .where('fecha', isGreaterThanOrEqualTo: fechaInicio)
        .where('fecha', isLessThanOrEqualTo: fechaFin);

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => Reserva.fromDoc(doc)).toList(),
    );
  }

  Stream<List<Reserva>> listarReservasJugadorRango({
    required String usuarioId,
    required String fechaInicio,
    required String fechaFin,
  }) {
    final query = _ref
        .where('usuarioId', isEqualTo: usuarioId)
        .where('fecha', isGreaterThanOrEqualTo: fechaInicio)
        .where('fecha', isLessThanOrEqualTo: fechaFin);

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

  /// Crea reserva pero si ya existe en ese slot, lanza error
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

  Future<void> crearReserva(
      String usuarioId,
      String pistaId,
      String fecha,
      String hora,
      ) async {
    await _ref.add({
      'usuarioId': usuarioId,
      'pistaId': pistaId,
      'fecha': fecha,
      'hora': hora,
    });
  }

  Future<void> modificarReserva(
      String id,
      String usuarioId,
      String pistaId,
      String fecha,
      String hora,
      ) async {
    await _ref.doc(id).update({
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