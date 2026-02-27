import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> _ref =
  FirebaseFirestore.instance.collection('usuarios');

  List<User> _users = [];
  bool _isLoading = false;
  String? _currentRolFilter;
  StreamSubscription? _subscription;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get currentRolFilter => _currentRolFilter;

  UserProvider() {
    loadUsers();
  }

  void loadUsers({String? rol}) {
    if (rol == "TODOS") {

    } else {

    }
  }

  Future<void> addUser(User user) async {
    final doc = _ref.doc();
    await doc.set(user.toMap());
  }

  Future<void> updateUser(String id, User user) async {
    await _ref.doc(id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _ref.doc(id).delete();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}