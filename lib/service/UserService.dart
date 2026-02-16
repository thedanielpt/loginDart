import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Stream<List<User>> watchUsers({String? rol}) {
    Query<Map<String, dynamic>> query = _db.collection('usuarios');

    if (rol != null) {
      query = query.where('rol', isEqualTo: rol);
    }

    query = query.orderBy('nombre');

    return query.snapshots().map(
          (snap) => snap.docs.map((doc) => User.fromDoc(doc)).toList(),
    );
  }
}