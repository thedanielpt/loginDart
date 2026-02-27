import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../service/userService.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();

  List<User> _users = [];
  bool _isLoading = false;
  StreamSubscription? _sub;

  User? _user;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  User? get user => _user;

  UserProvider() {
    escucharUsuarios();
  }

  void escucharUsuarios({String? rol}) {
    _isLoading = true;
    notifyListeners();

    _sub?.cancel();

    _sub = _service.listarUsuarios(rol: rol).listen(
          (lista) {
        _users = lista;
        _isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> cogerUserById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _service.cogerUserById(id);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.deleteUserEverywhere(id);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}