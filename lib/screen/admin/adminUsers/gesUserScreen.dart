import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/UserProvider.dart';
import '../../../widgets/admin/adminUsuarios/ButtonAdminUser.dart';
import '../../../widgets/admin/adminUsuarios/buildDropdown.dart';
import '../../../widgets/admin/adminUsuarios/userList.dart';
import '../../../widgets/admin/bottom_nav_bar.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  String pagina = "Gestión de Usuarios";
  String filtro = "TODOS";
  final List<String> roles = ["TODOS", "Admin", "Entrenador", "Jugador", "Arbitro"];

  int selectedTab = 0;

  late final List<BottomNavItem> navItems = const [
    BottomNavItem(label: "Dashboard", icon: Icons.home, route: "/admin"),
    BottomNavItem(label: "Salir", icon: Icons.exit_to_app, route: "/"),
    BottomNavItem(label: "Ajustes", icon: Icons.settings, route: null),
  ];

  /// Convierte el valor del dropdown al rol de Firestore (o null para todos)
  String? _mapFiltroToRol(String filtro) {
    switch (filtro) {
      case "TODOS":
        return null;
      case "Admin":
        return "admin";
      case "Entrenador":
        return "entrenador";
      case "Jugador":
        return "jugador";
      case "Arbitro":
        return "arbitro";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedTab: selectedTab,
        onTabSelected: (index) {
          setState(() => selectedTab = index);
        },
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
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: ButtonAdminUser(
                          text: "Crear cuenta",
                          onClick: () =>
                              Navigator.pushNamed(context, "/usuariosAdminCrear"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownFilterAdmin(
                          value: filtro,
                          items: roles,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() => filtro = newValue);

                              final rol = _mapFiltroToRol(newValue);
                              context.read<UserProvider>().escucharUsuarios(rol: rol);
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const Expanded(child: UserList()),

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
