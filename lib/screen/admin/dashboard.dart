import 'package:flutter/material.dart';
import '../../widgets/admin/dashboard/buttonDashboardAdmin.dart';

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
            width: 330,
            padding: const EdgeInsets.symmetric(vertical: 40),
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
                Column(
                  children: [
                    ButtonMenuAdmin(
                      text: 'Usuarios',
                      onPressed: () {
                        Navigator.pushNamed(context, '/usuariosAdmin');
                      },
                    ),
                    ButtonMenuAdmin(
                      text: 'Equipos',
                      onPressed: () {
                        Navigator.pushNamed(context, '/EquiposAdmin');
                      },
                    ),
                    ButtonMenuAdmin(
                      text: 'Cerrar sesión',
                      danger: true,
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ]
                      .map((widget) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: widget,
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
