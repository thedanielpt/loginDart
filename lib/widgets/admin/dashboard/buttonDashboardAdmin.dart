import 'package:flutter/material.dart';

class CardMenuAdmin extends StatelessWidget {
  final String text;
  final bool danger;
  final VoidCallback onClick;

  const CardMenuAdmin({
    super.key,
    required this.text,
    this.danger = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          // Si es danger usamos el rojo, si no el azul oscuro con opacidad
          color: danger ? const Color(0xFF8B1E1E) : const Color(0xCC2C2C54),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xCCA6A6C5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 4), // Elevación
            ),
          ],
        ),
        // Center se encarga de que el texto esté justo en medio
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}