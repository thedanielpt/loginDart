import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/Reserva.dart';
import '../../../provider/ReservaProvider.dart';

class ReservaList extends StatelessWidget {
  const ReservaList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservaProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final reservas = provider.reservas;

    if (reservas.isEmpty) {
      return const Center(child: Text("No hay reservas"));
    }

    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (context, index) {
        final r = reservas[index];

        return ListTile(
          title: Text("Usuario: ${r.usuarioId} - Pista: ${r.pistaId}"),
          subtitle: Text("${r.fecha} - ${r.hora}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.read<ReservaProvider>().cogerReservaById(r.id as String);
                  Navigator.pushNamed(context, "/reservasAdminModificar");
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<ReservaProvider>().deleteReserva(r.id as String);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}