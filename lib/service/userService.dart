import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final _ref = FirebaseFirestore.instance.collection('usuarios');

  // Stream para la lista de usuarios
  Stream<List<User>> listarUsuarios({String? rol}) {
    Query<Map<String, dynamic>> query = _ref;
    if (rol != null && rol != "TODOS") {
      query = query.where('rol', isEqualTo: rol);
    }
    return query.snapshots().map((snap) =>
        snap.docs.map((doc) => User.fromDoc(doc)).toList()
    );
  }

  // Método para borrar en Firestore
  Future<void> eliminarDeFirestore(String id) async {
    await _ref.doc(id).delete();
  }
}