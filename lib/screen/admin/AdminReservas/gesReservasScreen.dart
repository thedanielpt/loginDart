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
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReservaProvider>().escucharReservas(); 
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
      context.read<ReservaProvider>().escucharReservas(); 
    } else {
      context.read<ReservaProvider>().escucharReservas(fecha: fecha);
    }
  }

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