import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final _ref = FirebaseFirestore.instance.collection('usuarios');

  Future<String> addUser(User user) async {
    final doc = _ref.doc();
    await doc.set(user.toMap());
    return doc.id;
  }

  Stream<List<User>> listarUsuarios({String? rol}) {
    Query<Map<String, dynamic>> query = _ref;

    // Si rol es null o "TODOS", no filtramos nada
    if (rol != "TODOS") {
      query = query.where('rol', isEqualTo: rol);
    }

    return query.snapshots().map((snap) {
      return snap.docs.map((doc) => User.fromDoc(doc)).toList();
    });
  }
}