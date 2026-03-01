import 'package:flutter/material.dart';
import '../../models/Reserva.dart';

class ReservaCard extends StatelessWidget {
  final Reserva reserva;
  // En Dart, si quieres traer el nombre de la pista,
  // podrías pasar el String nombrePista o usar un FutureBuilder/Provider aquí.

  const ReservaCard({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xCC2C2C54),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xCCA6A6C5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reserva #${reserva.id.substring(0, 5)}...",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text("Pista: ${reserva.pistaId}", style: const TextStyle(color: Color(0xFFE6E6F2), fontSize: 14)),
          Text("Fecha: ${reserva.fecha}", style: const TextStyle(color: Color(0xFFE6E6F2), fontSize: 14)),
          Text("Hora: ${reserva.hora}", style: const TextStyle(color: Color(0xFFE6E6F2), fontSize: 14)),
        ],
      ),
    );
  }
}