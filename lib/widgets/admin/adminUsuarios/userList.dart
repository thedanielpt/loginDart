import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/UserProvider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
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
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final user = users[index];

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xCC2C2C54),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xCCA6A6C5), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
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
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFFB6B6FF)),
                    onPressed: () async {
                      if (user.id == null) return;
                      provider.cogerUserById(user.id!);
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, "/usuariosAdminModificar");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFFF6B6B)),
                    onPressed: () async {
                      final bool confirmar =
                      await _mostrarDialogoConfirmacion(context);

                      if (confirmar && user.id != null) {
                        await context.read<UserProvider>().deleteUser(user.id!);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Usuario eliminado correctamente"),
                          ),
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
        title: const Text("¿Eliminar usuario?",
            style: TextStyle(color: Colors.white)),
        content: const Text(
          "Esta acción no se puede deshacer.",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("CANCELAR"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("ELIMINAR",
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ??
        false;
  }
}