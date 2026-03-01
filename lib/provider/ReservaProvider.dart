import 'dart:async';
import 'package:flutter/material.dart';
import '../models/Reserva.dart';
import '../service/reservaService.dart';

class ReservaProvider extends ChangeNotifier {
  final ReservaService _service = ReservaService();

  // listas
  List<Reserva> _reservas = [];
  List<Reserva> _reservasJugador = [];
  Reserva? _reserva;

  // estado
  bool _isLoading = false;
  String? _error;

  // subs separadas (no se pisan)
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
    // yyyy-MM-dd + HH:mm => orden lexicográfico OK
    final fa = "${a.fecha} ${a.hora}";
    final fb = "${b.fecha} ${b.hora}";
    return fa.compareTo(fb);
  }

  // helper fechas
  String _ymd(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return "$y-$m-$day";
  }

  // ======================
  // ADMIN: escuchar todas / por fecha
  // ======================
  void escucharReservas({String? fecha}) {
    _setLoading(true);
    _setError(null);

    _subReservas?.cancel();
    _subReservas = _service.listarReservas(fecha: fecha).listen(
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

  // ======================
  // JUGADOR: escuchar sus reservas
  // ======================
  void escucharReservasJugador(String usuarioId, {String? fecha}) {
    _setLoading(true);
    _setError(null);

    _subReservasJugador?.cancel();
    _subReservasJugador = _service.listarReservasJugador(usuarioId, fecha: fecha).listen(
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

  // ======================
  // FILTROS ADMIN
  // ======================
  void filtrarHoyAdmin() {
    final hoy = _ymd(DateTime.now());
    escucharReservas(fecha: hoy);
  }

  void filtrarSemanaPasadaAdmin() {
    final now = DateTime.now();
    final ini = _ymd(now.subtract(const Duration(days: 7)));
    final fin = _ymd(now);
    _setLoading(true);
    _setError(null);
    _subReservas?.cancel();
    _subReservas = _service.listarReservasRango(fechaInicio: ini, fechaFin: fin).listen(
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

  void filtrarSemanaQueVieneAdmin() {
    final now = DateTime.now();
    final ini = _ymd(now);
    final fin = _ymd(now.add(const Duration(days: 7)));
    _setLoading(true);
    _setError(null);
    _subReservas?.cancel();
    _subReservas = _service.listarReservasRango(fechaInicio: ini, fechaFin: fin).listen(
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

  void quitarFiltrosAdmin() => escucharReservas();

  // ======================
  // FILTROS JUGADOR
  // ======================
  void filtrarHoyJugador(String usuarioId) {
    final hoy = _ymd(DateTime.now());
    escucharReservasJugador(usuarioId, fecha: hoy);
  }

  void filtrarSemanaPasadaJugador(String usuarioId) {
    final now = DateTime.now();
    final ini = _ymd(now.subtract(const Duration(days: 7)));
    final fin = _ymd(now);
    _setLoading(true);
    _setError(null);
    _subReservasJugador?.cancel();
    _subReservasJugador = _service
        .listarReservasJugadorRango(usuarioId: usuarioId, fechaInicio: ini, fechaFin: fin)
        .listen(
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

  void filtrarSemanaQueVieneJugador(String usuarioId) {
    final now = DateTime.now();
    final ini = _ymd(now);
    final fin = _ymd(now.add(const Duration(days: 7)));
    _setLoading(true);
    _setError(null);
    _subReservasJugador?.cancel();
    _subReservasJugador = _service
        .listarReservasJugadorRango(usuarioId: usuarioId, fechaInicio: ini, fechaFin: fin)
        .listen(
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

  // ======================
  // CRUD
  // ======================
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