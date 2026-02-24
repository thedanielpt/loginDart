import 'package:flutter/material.dart';

import '../../widgets/admin/bottom_nav_bar.dart';
import '../../widgets/admin/dashboard/AdminCard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedTab = 0;

  // Items como en Compose (route null = acción)
  late final List<BottomNavItem> navItems = const [
    BottomNavItem(label: "Dashboard", icon: Icons.home, route: "/admin"),
    BottomNavItem(label: "Salir", icon: Icons.exit_to_app, route: "/"),
    BottomNavItem(label: "Ajustes", icon: Icons.settings, route: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      // ✅ AQUÍ YA VA TU BottomNavBar CUSTOM
      bottomNavigationBar: BottomNavBar(
        selectedTab: selectedTab,
        onTabSelected: (index) {
          setState(() => selectedTab = index);

          // Si quieres hacer algo en Ajustes (route null)
          if (index == 2) {
            // TODO: abrir modal o navegar a ajustes si creas la ruta
            // showModalBottomSheet(...);
          }
        },
        items: navItems,
      ),

      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/rafa.png",
              fit: BoxFit.cover,
            ),
          ),

          Center(
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
                    "Panel de Administración",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              AdminCard("Usuarios", () {
                                Navigator.pushNamed(context, "/usuariosAdmin");
                              }),
                              const SizedBox(height: 14),
                              AdminCard("Partidos", () {
                                // ✅ OJO: en tus rutas es "/PartidosAdmin" (P mayúscula)
                                Navigator.pushNamed(context, "/PartidosAdmin");
                              }),
                              const SizedBox(height: 14),
                              AdminCard("Pistas", () {
                                // ✅ OJO: en tus rutas es "/PistasAdmin"
                                Navigator.pushNamed(context, "/PistasAdmin");
                              }),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: Column(
                            children: [
                              AdminCard("Equipos", () {
                                // ✅ OJO: en tus rutas es "/EquiposAdmin"
                                Navigator.pushNamed(context, "/EquiposAdmin");
                              }),
                              const SizedBox(height: 14),
                              AdminCard("Reservas", () {
                                // ✅ OJO: en tus rutas es "/ReservasAdmin"
                                Navigator.pushNamed(context, "/ReservasAdmin");
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}