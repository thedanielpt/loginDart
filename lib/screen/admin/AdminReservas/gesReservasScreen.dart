import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/ReservaProvider.dart';
import '../../../widgets/admin/adminUsuarios/ButtonAdminUser.dart';
import '../../../widgets/admin/bottom_nav_bar.dart';
import '../../../widgets/admin/adminReservas/ReservaList.dart';

class AdminReservasScreen extends StatefulWidget {
  const AdminReservasScreen({super.key});

  @override
  State<AdminReservasScreen> createState() => _AdminReservasScreenState();
}

class _AdminReservasScreenState extends State<AdminReservasScreen> {
  String pagina = "Gestión de Reservas";

  int selectedTab = 0;
  late final List<BottomNavItem> navItems = const [
    BottomNavItem(label: "Dashboard", icon: Icons.home, route: "/admin"),
    BottomNavItem(label: "Salir", icon: Icons.exit_to_app, route: "/"),
    BottomNavItem(label: "Ajustes", icon: Icons.settings, route: null),
  ];

  final TextEditingController _fechaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Cargar todas al entrar (por si no se hizo en el provider constructor)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReservaProvider>().escucharReservas(); // todas
    });
  }

  @override
  void dispose() {
    _fechaController.dispose();
    super.dispose();
  }

  void _filtrarPorFecha() {
    final fecha = _fechaController.text.trim();
    if (fecha.isEmpty) {
      context.read<ReservaProvider>().escucharReservas(); // todas
    } else {
      context.read<ReservaProvider>().escucharReservas(fecha: fecha);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedTab: selectedTab,
        onTabSelected: (index) => setState(() => selectedTab = index),
        items: navItems,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/rafa.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.95,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xCC1A1A40),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    pagina,
                    style: const TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: ButtonAdminUser(
                          text: "Crear reserva",
                          onClick: () => Navigator.pushNamed(
                            context,
                            "/ReservasAdminCrear",
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const Expanded(child: ReservaList()),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}