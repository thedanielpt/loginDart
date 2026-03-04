import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Reserva.dart';
import '../service/reservaService.dart';

class ReservaProvider extends ChangeNotifier {
  final ReservaService _service = ReservaService();

  
  List<Reserva> _reservas = [];
  List<Reserva> _reservasJugador = [];
  Reserva? _reserva;

  
  bool _isLoading = false;
  String? _error;

  List<String> _horasOcupadas = [];
  List<String> get horasOcupadas => _horasOcupadas;

  bool _isLoadingHoras = false;
  bool get isLoadingHoras => _isLoadingHoras;

  
  StreamSubscription? _subReservas;
  StreamSubscription? _subReservasJugador;

  List<Reserva> get reservas => _reservas;
  List<Reserva> get reservasJugador => _reservasJugador;
  Reserva? get reserva => _reserva;

  bool get isLoading => _isLoading;
  String? get error => _error;

  ReservaProvider() {
    escucharReservas();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void _setError(String? msg) {
    _error = msg;
    notifyListeners();
  }

  int _cmpFechaHora(Reserva a, Reserva b) {
    
    final fa = "${a.fecha} ${a.hora}";
    final fb = "${b.fecha} ${b.hora}";
    return fa.compareTo(fb);
  }

  void escucharReservas({String? fecha}) {
    _setLoading(true);
    _setError(null);

    _subReservas?.cancel();
    _subReservas = _service.listarReservas().listen(
          (lista) {
        lista.sort(_cmpFechaHora);
        _reservas = lista;
        _setLoading(false);
      },
      onError: (e) {
        _reservas = [];
        _setLoading(false);
        _setError(e.toString());
      },
    );
  }

  Future<void> cargarHorasOcupadas(String fecha, String pistaId) async {
    _isLoadingHoras = true;
    _horasOcupadas = []; 
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("reservas") 
          .where("fecha", isEqualTo: fecha)
          .where("pistaId", isEqualTo: pistaId)
          .get();

      
      _horasOcupadas = snapshot.docs.map((doc) => doc['hora'].toString()).toList();

      print("Horas ocupadas cargadas: $_horasOcupadas");
    } catch (e) {
      print("Error al cargar horas ocupadas: $e");
    } finally {
      _isLoadingHoras = false;
      notifyListeners();
    }
  }
  
  
  void escucharReservasJugador(String usuarioId) {
    _setLoading(true);
    _setError(null);

    _subReservasJugador?.cancel();
    _subReservasJugador = _service.listarReservasJugador(usuarioId).listen(
          (lista) {
        lista.sort(_cmpFechaHora);
        _reservasJugador = lista;
        _setLoading(false);
      },
      onError: (e) {
        _reservasJugador = [];
        _setLoading(false);
        _setError(e.toString());
      },
    );
  }

  void quitarFiltrosJugador(String usuarioId) => escucharReservasJugador(usuarioId);
  
  Future<void> cogerReservaById(String id) async {
    _setLoading(true);
    _setError(null);
    try {
      _reserva = await _service.cogerReservaById(id);
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  Future<void> crearReservaSeguro(
      String usuarioId,
      String pistaId,
      String fecha,
      String hora,
      ) async {
    _setError(null);
    try {
      await _service.crearReservaSeguro(usuarioId, pistaId, fecha, hora);
    } catch (e) {
      _setError(e.toString());
      rethrow;
    }
  }

  Future<void> deleteReserva(String id) async {
    _setError(null);
    try {
      await _service.deleteReserva(id);
    } catch (e) {
      _setError(e.toString());
    }
  }

  @override
  void dispose() {
    _subReservas?.cancel();
    _subReservasJugador?.cancel();
    super.dispose();
  }
}