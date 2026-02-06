import 'package:flutter/material.dart';

import '../../../widgets/admin/adminUsuarios/buildAdminButton.dart';
import '../../../widgets/admin/adminUsuarios/buildDropdown.dart';
// Importa tus widgets aquí
// import 'package:tu_proyecto/widgets/button_admin_user.dart';
// import 'package:tu_proyecto/widgets/dropdown_filter_admin.dart';
// import 'package:tu_proyecto/widgets/user_listar_usuarios.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  // Estados de la pantalla
  String pagina = "Gestión de Usuarios";
  String filtro = "TODOS";
  final List<String> roles = ["TODOS", "Admin", "Entrenador", "Jugador", "Arbitro"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // Título
                  Text(
                    pagina,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Fila: Botón Crear + Dropdown Filtro
                  Row(
                    children: [
                      Expanded(
                        child: ButtonAdminUser(
                          text: "Crear cuenta",
                          onClick: () => Navigator.pushNamed(context, "Crear_usuario"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownFilterAdmin(
                          value: filtro,
                          items: roles,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                filtro = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /*const Expanded(
                    child: UserListarUsuarios(),
                  ),*/

                  const SizedBox(height: 20),

                  ButtonAdminUser(
                    text: "Principio",
                    fullWidth: true,
                    onClick: () => Navigator.pushNamed(context, "admin"),
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