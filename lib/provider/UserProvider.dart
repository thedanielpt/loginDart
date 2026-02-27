import 'dart:async';
import 'package:flutter/material.dart';
import '../models/User.dart';
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
        _users = lista.cast<User>();
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
      _user = (await _service.cogerUserById(id)) as User?;
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

  Future<void> modificarUsuario(String uid, String nuevoNombre, String nuevoRol) async {
    await _service.modificarUsuario(uid, nuevoNombre, nuevoRol);
    _user = null;
  }

  Future<void> crearUsuario({
    required String email,
    required String password,
    required String nombre,
    required String rol,
  }) async {
    try {
      await _service.crearUsuario(email, password, nombre, rol);
    } finally {
      notifyListeners();
      _user = null;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}