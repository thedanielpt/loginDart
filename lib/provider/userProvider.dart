import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../service/userService.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();

  List<User> _users = [];
  bool _isLoading = false;
  StreamSubscription? _sub;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  UserProvider() {
    escucharUsuarios();
  }

  void escucharUsuarios({String? rol}) {
    _isLoading = true;
    notifyListeners();

    _sub?.cancel();

    // El Provider se suscribe al Stream que le da el servicio
    _sub = _service.listarUsuarios(rol: rol).listen(
            (lista) {
          _users = lista;
          _isLoading = false;
          notifyListeners();
        },
        onError: (e) {
          _isLoading = false;
          notifyListeners();
        }
    );
  }

  Future<void> deleteUser(String id) async {
    try {
      // 1. Hablamos con el servicio para borrar de la DB
      await _service.eliminarDeFirestore(id);

      // 2. Lógica de Auth (esta se queda en el provider o un AuthService)
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.uid == id) {
        await currentUser.delete();
      }

      // No hace falta cargar de nuevo, porque el Stream (_sub)
      // detectará el borrado en Firestore y actualizará la lista solo.
    } catch (e) {
      throw Exception("Error al eliminar: $e");
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}