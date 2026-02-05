import 'package:flutter/material.dart';

class AdminReservasScreen extends StatelessWidget {
  const AdminReservasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/rafa.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Reservas',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(blurRadius: 5, color: Colors.black, offset: Offset(2, 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}