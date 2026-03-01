import 'dart:async';
import 'package:flutter/material.dart';
import '../models/Pista.dart';
import '../service/pistaService.dart';

class PistaProvider extends ChangeNotifier {
  final PistaService _service = PistaService();

  List<Pista> _pistas = [];
  Pista? _pista;
  bool _isLoading = false;
  StreamSubscription? _sub;

  List<Pista> get pistas => _pistas;
  Pista? get pista => _pista;
  bool get isLoading => _isLoading;

  PistaProvider() {
    escucharPistas();
  }

  
  void escucharPistas({bool? activa, String? tipo}) {
    _isLoading = true;
    notifyListeners();

    _sub?.cancel();

    _sub = _service.listarPistas(activa: activa, tipo: tipo).listen(
          (lista) {
        _pistas = lista;
        _isLoading = false;
        notifyListeners();
      },
      onError: (_) {
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  
  Future<void> cogerPistaById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _pista = await _service.cogerPistaById(id);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  
  Future<String> crearPista({
    required String nombre,
    required String tipo,
    required bool activa,
    int? numero,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final id = await _service.crearPista(
        nombre: nombre,
        tipo: tipo,
        activa: activa,
        numero: numero,
      );
      return id;
    } finally {
      _isLoading = false;
      _pista = null;
      notifyListeners();
    }
  }

  
  Future<void> modificarPista(
      String id, {
        required String nombre,
        required String tipo,
        required bool activa,
        int? numero,
      }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.modificarPista(
        id,
        nombre: nombre,
        tipo: tipo,
        activa: activa,
        numero: numero,
      );
    } finally {
      _isLoading = false;
      _pista = null;
      notifyListeners();
    }
  }

  
  Future<void> deletePista(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.deletePista(id);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  
  Future<void> setActiva(String id, bool activa) async {
    await _service.setActiva(id, activa);
  }

  void limpiarSeleccion() {
    _pista = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}