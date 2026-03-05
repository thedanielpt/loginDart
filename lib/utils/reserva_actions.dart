import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ReservaProvider.dart';
import '../provider/UserProvider.dart';

class ReservaActions {

  static void checkHorasOcupadas(
      BuildContext context,
      String? pistaId,
      String fecha,
      ) {
    if (pistaId != null && fecha.isNotEmpty) {
      context.read<ReservaProvider>().cargarHorasOcupadas(fecha, pistaId);
    }
  }

  static Future<String?> enviarReserva(
      BuildContext context,
      String? pistaId,
      String fecha,
      String hora,
      ) async {

    final user = context.read<UserProvider>().user;

    if (pistaId == null || fecha.isEmpty || hora.isEmpty) {
      return "Rellena pista, fecha y hora.";
    }

    try {
      await context.read<ReservaProvider>().crearReservaSeguro(
        user!.id!,
        pistaId,
        fecha,
        hora,
      );

      return null; // todo bien
    } catch (e) {
      return e.toString();
    }
  }
}