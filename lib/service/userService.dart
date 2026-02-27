import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final CollectionReference<Map<String, dynamic>> _ref =
  FirebaseFirestore.instance.collection("usuarios");

  Future<String> addUser(User user) async {
    final doc = _ref.doc();
    await doc.set(user.toMap());
    return doc.id;
  }

  Stream<List<User>> watchUsers({String? rol}) {
    Query<Map<String, dynamic>> query = _ref;

    if (rol != null) {
      query = query.where('rol', isEqualTo: rol);
    }

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => User.fromDoc(doc)).toList(),
    );
  }

  Future<void> updateUser(String id, User user) {
    return _ref.doc(id).update(user.toMap());
  }

  Future<void> deleteUser(String id) {
    return _ref.doc(id).delete();
  }

  // Si quieres, deja este como alias del anterior:
  Stream<List<User>> getUsersByRole(String role) {
    return watchUsers(rol: role);
  }
}