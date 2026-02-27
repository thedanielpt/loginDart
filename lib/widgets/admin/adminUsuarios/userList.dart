import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/UserProvider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  Color _rolColor(String rol) {
    switch (rol.toLowerCase()) {
      case "admin":
        return Colors.redAccent;
      case "entrenador":
        return Colors.lightBlueAccent;
      case "jugador":
        return Colors.lightGreenAccent;
      case "arbitro":
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData _rolIcon(String rol) {
    switch (rol.toLowerCase()) {
      case "admin":
        return Icons.shield;
      case "entrenador":
        return Icons.sports;
      case "jugador":
        return Icons.sports_soccer;
      case "arbitro":
        return Icons.gavel;
      default:
        return Icons.person;
    }
  }

  String _rolLabel(String rol) {
    switch (rol.toLowerCase()) {
      case "admin":
        return "ADMIN";
      case "entrenador":
        return "ENTRENADOR";
      case "jugador":
        return "JUGADOR";
      case "arbitro":
        return "ARBITRO";
      default:
        return rol.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final users = provider.users;

    if (users.isEmpty) {
      return const Center(
        child: Text("No hay usuarios", style: TextStyle(color: Colors.white70)),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      itemCount: users.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final u = users[index];
        final rolColor = _rolColor(u.rol);
        final rolIcon = _rolIcon(u.rol);

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xB31A1A40),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.10), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: rolColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: rolColor.withOpacity(0.60), width: 1.5),
              ),
              alignment: Alignment.center,
              child: Icon(rolIcon, color: rolColor, size: 22),
            ),
            title: Text(
              u.nombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: rolColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: rolColor.withOpacity(0.60), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(rolIcon, size: 14, color: rolColor),
                    const SizedBox(width: 6),
                    Text(
                      _rolLabel(u.rol),
                      style: TextStyle(
                        color: rolColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    final id = u.id;
                    if (id == null || id.isEmpty) return;
                    context.read<UserProvider>().deleteUser(id);
                  },
                ),
                const Icon(Icons.chevron_right, color: Colors.white70),
              ],
            ),
          ),
        );
      },
    );
  }
}