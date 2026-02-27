import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../models/user.dart';

class UserService {
  final _ref = FirebaseFirestore.instance.collection('usuarios');
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  // 🔹 Stream lista usuarios
  Stream<List<User>> listarUsuarios({String? rol}) {
    Query<Map<String, dynamic>> query = _ref;

    if (rol != null && rol != "TODOS") {
      query = query.where('rol', isEqualTo: rol);
    }

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => User.fromDoc(doc)).toList(),
    );
  }

  // 🔹 Obtener usuario por ID
  Future<User?> cogerUserById(String id) async {
    final doc = await _ref.doc(id).get();
    if (!doc.exists) return null;
    return User.fromDoc(doc);
  }

  Future<void> eliminarDeFirestore(String id) async {
    await _ref.doc(id).delete();
  }

  Future<void> eliminarAuthSiEsCurrentUser(String id) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.uid == id) {
      await currentUser.delete();
    }
  }

  Future<void> deleteUserEverywhere(String id) async {
    await eliminarDeFirestore(id);
    await eliminarAuthSiEsCurrentUser(id);
  }
}