import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Pista.dart';

class PistaService {
  final CollectionReference<Map<String, dynamic>> _ref =
  FirebaseFirestore.instance.collection('pistas');

  
  Stream<List<Pista>> listarPistas({bool? activa, String? tipo}) {
    Query<Map<String, dynamic>> query = _ref;

    if (activa != null) {
      query = query.where('activa', isEqualTo: activa);
    }
    if (tipo != null && tipo.isNotEmpty && tipo != "TODOS") {
      query = query.where('tipo', isEqualTo: tipo);
    }

    
    

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => Pista.fromDoc(doc)).toList(),
    );
  }

  
  Future<Pista?> cogerPistaById(String id) async {
    final doc = await _ref.doc(id).get();
    if (!doc.exists) return null;
    return Pista.fromDoc(doc);
  }

  
  Future<String> crearPista({
    required String nombre,
    required String tipo,
    required bool activa,
    int? numero,
  }) async {
    final doc = await _ref.add({
      'nombre': nombre,
      'tipo': tipo,
      'activa': activa,
      if (numero != null) 'numero': numero,
    });

    return doc.id;
  }

  
  Future<void> modificarPista(
      String id, {
        required String nombre,
        required String tipo,
        required bool activa,
        int? numero,
      }) async {
    await _ref.doc(id).update({
      'nombre': nombre,
      'tipo': tipo,
      'activa': activa,
      if (numero != null) 'numero': numero,
    });
  }

  
  Future<void> deletePista(String id) async {
    await _ref.doc(id).delete();
  }

  
  Future<void> setActiva(String id, bool activa) async {
    await _ref.doc(id).update({'activa': activa});
  }
}