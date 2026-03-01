import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/ReservaProvider.dart';
import '../../provider/UserProvider.dart';

class CrearReservaPorJugador extends StatefulWidget {
  const CrearReservaPorJugador({super.key});

  @override
  State<CrearReservaPorJugador> createState() => _CrearReservaPorJugadorState();
}

class _CrearReservaPorJugadorState extends State<CrearReservaPorJugador> {
  final _formKey = GlobalKey<FormState>();
  String _pistaId = "Pista 1";
  String _fecha = DateTime.now().toString().substring(0, 10);
  String _hora = "10:00";

  void _guardarReserva() async {
    // RECOGEMOS EL ID DEL PROVIDER
    final user = context.read<UserProvider>().user;

    if (user == null || user.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Usuario no identificado")),
      );
      return;
    }

    try {
      await context.read<ReservaProvider>().crearReservaSeguro(
        user.id!, // ID del provider
        _pistaId,
        _fecha,
        _hora,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("¡Reserva confirmada!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A40),
      appBar: AppBar(
        title: const Text("Nueva Reserva"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("¿Dónde quieres jugar?", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _pistaId,
                dropdownColor: const Color(0xFF2C2C54),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0x33FFFFFF),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: ["Pista 1", "Pista 2", "Pista Central", "Pista de Pádel"]
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (val) => setState(() => _pistaId = val!),
              ),
              const SizedBox(height: 25),

              // Selector de Fecha
              const Text("Fecha", style: TextStyle(color: Colors.white70)),
              ListTile(
                tileColor: const Color(0x33FFFFFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                title: Text(_fecha, style: const TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.calendar_today, color: Colors.greenAccent),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2027),
                  );
                  if (picked != null) setState(() => _fecha = picked.toString().substring(0, 10));
                },
              ),
              const SizedBox(height: 20),

              // Selector de Hora
              const Text("Hora", style: TextStyle(color: Colors.white70)),
              ListTile(
                tileColor: const Color(0x33FFFFFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                title: Text(_hora, style: const TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.access_time, color: Colors.greenAccent),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() => _hora = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}");
                  }
                },
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E54C8),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _guardarReserva,
                child: const Text("CONFIRMAR RESERVA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}