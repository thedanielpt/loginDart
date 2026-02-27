import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/UserProvider.dart';


class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el provider
    final provider = context.watch<UserProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final users = provider.users;

    if (users.isEmpty) {
      return const Center(
        child: Text(
          "No hay usuarios",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: users.length,
      // El separador es el Spacer que usabas entre cajas en Compose
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final user = users[index];

        // Este es el equivalente exacto a tu "CajaListar" de Compose
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            // Color de fondo: Color(0xCC2C2C54)
            color: const Color(0xCC2C2C54),
            borderRadius: BorderRadius.circular(14),
            // Borde: BorderStroke(1.dp, Color(0xCCA6A6C5))
            border: Border.all(
              color: const Color(0xCCA6A6C5),
              width: 1,
            ),
          ),
          child: Row(
            // ESTA es la propiedad que buscas. Equivale a Alignment.CenterVertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  // Para que los textos se alineen a la izquierda
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.nombre,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.rol,
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFFB6B6FF)),
                    onPressed: () => Navigator.pushNamed(context, 'Modificar_usuario/${user.id}'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFFF6B6B)),
                    onPressed: () async {
                      // 1. Esperamos a que el usuario responda al diálogo
                      final bool? confirmar = await _mostrarDialogoConfirmacion(context);

                      // 2. Si el usuario pulsó "ELIMINAR" (true)
                      if (confirmar == true && user.id != null) {
                        // Llamamos a tu función del provider (le ponemos el ! porque ya checkeamos null)
                        await provider.deleteUser(user.id!);

                        // Opcional: Mostrar un mensaje rápido de éxito
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Usuario eliminado correctamente")),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _mostrarDialogoConfirmacion(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text("¿Eliminar usuario?", style: TextStyle(color: Colors.white)),
        content: const Text("Esta acción no se puede deshacer.", style: TextStyle(color: Colors.white),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("CANCELAR"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("ELIMINAR", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ?? false;
  }
}