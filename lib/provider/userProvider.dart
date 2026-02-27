import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final _ref = FirebaseFirestore.instance.collection('usuarios');

  List<User> _users = [];
  bool _isLoading = false;
  StreamSubscription? _sub;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  UserProvider() {
    escucharUsuarios(); // al iniciar: trae TODOS
  }

  // rol == null => TODOS
  void escucharUsuarios({String? rol}) {
    _isLoading = true;
    notifyListeners();

    // corta la escucha anterior
    _sub?.cancel();

    Query<Map<String, dynamic>> query = _ref;

    // si rol NO es null => filtramos
    if (rol != null) {
      query = query.where('rol', isEqualTo: rol);
    }

    _sub = query.snapshots().listen(
          (snap) {
        _users = snap.docs.map((d) => User.fromDoc(d)).toList();
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        print("Error leyendo usuarios: $e");
        _users = [];
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> deleteUser(String id) async {
    await _ref.doc(id).delete();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}