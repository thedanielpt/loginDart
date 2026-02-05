import 'package:flutter/material.dart';
import '../../widgets/admin/dashboard/buttonDashboardAdmin.dart'; // Asegúrate de que el nombre del archivo coincida

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/rafa.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xCC1A1A40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Panel de Administración',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Columna 1
                    Expanded(
                      child: Column(
                        children: [
                          CardMenuAdmin(
                            text: 'Usuarios',
                            onClick: () => Navigator.pushNamed(context, '/usuariosAdmin'),
                          ),
                          const SizedBox(height: 14),
                          CardMenuAdmin(
                            text: 'Partidos',
                            onClick: () => Navigator.pushNamed(context, '/PartidosAdmin'),
                          ),
                          const SizedBox(height: 14),
                          CardMenuAdmin(
                            text: 'Pistas',
                            onClick: () => Navigator.pushNamed(context, '/PistasAdmin'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        children: [
                          CardMenuAdmin(
                            text: 'Equipos',
                            onClick: () => Navigator.pushNamed(context, '/EquiposAdmin'),
                          ),
                          const SizedBox(height: 14),
                          CardMenuAdmin(
                            text: 'Reservas',
                            onClick: () => Navigator.pushNamed(context, '/ReservasAdmin'),
                          ),
                          const SizedBox(height: 14),
                          CardMenuAdmin(
                            text: 'Cerrar Sesión',
                            danger: true,
                            onClick: () => Navigator.pushNamed(context, '/'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}