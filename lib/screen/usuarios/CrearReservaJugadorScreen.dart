import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/ReservaProvider.dart';
import '../../provider/UserProvider.dart';
import '../../widgets/admin/bottom_nav_bar.dart';

class CrearReservaPorJugador extends StatefulWidget {
  const CrearReservaPorJugador({super.key});

  @override
  State<CrearReservaPorJugador> createState() => _CrearReservaPorJugadorState();
}

class _CrearReservaPorJugadorState extends State<CrearReservaPorJugador> {
  int _selectedTab = 0;
  String? _pistaId;
  String _fecha = ""; // YYYY-MM-DD
  String _hora = "";   // HH:MM
  String? _error;

  // Lista de horas totales (la "lista fija" que mencionas en tu Kotlin)
  final List<String> _todasLasHoras = [
    "09:00", "10:00", "11:00", "12:00", "13:00",
    "16:00", "17:00", "18:00", "19:00", "20:00", "21:00"
  ];

  @override
  Widget build(BuildContext context) {
    final reservaProvider = context.watch<ReservaProvider>();
    final userProvider = context.watch<UserProvider>();

    // Simulamos el LaunchedEffect de Kotlin: Filtrar horas disponibles
    // horasDisponibles = todas - ocupadas
    List<String> horasDisponibles = _todasLasHoras
        .where((h) => !reservaProvider.horasOcupadas.contains(h))
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        backgroundColor: const Color(0xFF1A1A40),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedTab = index);
          if (index == 1) Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), label: 'Salir'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
      body: Stack(
        children: [
          // 1. Fondo de imagen (Rafa) - ContentScale.Crop
          Positioned.fill(
            child: Image.asset('assets/rafa.png', fit: BoxFit.cover),
          ),
          // 2. Capa oscura (Color(0x99000000))
          Positioned.fill(
            child: Container(color: const Color(0x99000000)),
          ),
          // 3. Contenido centrado
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xCC1A1A40), // Mismo color que tu Kotlin
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Crear Reserva",
                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 18),

                    if (_error != null) ...[
                      Text(_error!, style: const TextStyle(color: Color(0xFFFFB4B4))),
                      const SizedBox(height: 10),
                    ],

                    // --- PISTA (Dropdown) ---
                    _buildLabel("Pista"),
                    DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xFF1A1A40),
                      style: const TextStyle(color: Colors.white),
                      value: _pistaId,
                      decoration: _inputDecoration("Selecciona una pista"),
                      items: ["1", "2", "3", "4"].map((id) {
                        return DropdownMenuItem(value: id, child: Text("Pista $id"));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _pistaId = val;
                          _hora = ""; // Reset hora como en tu Kotlin
                        });
                        _checkHorasOcupadas();
                      },
                    ),

                    const SizedBox(height: 12),

                    // --- FECHA (DatePicker) ---
                    _buildLabel("Fecha"),
                    InkWell(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 1)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2027),
                        );
                        if (picked != null) {
                          setState(() {
                            _fecha = picked.toString().substring(0, 10);
                            _hora = ""; // Reset hora
                          });
                          _checkHorasOcupadas();
                        }
                      },
                      child: InputDecorator(
                        decoration: _inputDecoration("Elegir fecha"),
                        child: Text(_fecha.isEmpty ? "Elegir" : _fecha, style: const TextStyle(color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // --- HORA (Dropdown Filtrado) ---
                    _buildLabel("Hora"),
                    DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xFF1A1A40),
                      style: const TextStyle(color: Colors.white),
                      value: _hora.isEmpty ? null : _hora,
                      decoration: _inputDecoration("Selecciona hora"),
                      items: (_pistaId == null || _fecha.isEmpty)
                          ? [const DropdownMenuItem(value: null, enabled: false, child: Text("Elige pista y fecha primero"))]
                          : horasDisponibles.map((h) {
                        return DropdownMenuItem(value: h, child: Text(h));
                      }).toList(),
                      onChanged: (val) => setState(() => _hora = val ?? ""),
                    ),

                    const SizedBox(height: 30),

                    // --- BOTÓN CREAR ---
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xCC2C2C54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color(0xCCA6A6C5)),
                          ),
                        ),
                        onPressed: _enviarReserva,
                        child: const Text("Crear Reserva", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _checkHorasOcupadas() {
    if (_pistaId != null && _fecha.isNotEmpty) {
      // Elimina el int.parse y el as String. Usa la variable directamente.
      context.read<ReservaProvider>().cargarHorasOcupadas(_fecha, _pistaId!);
    }
  }

  void _enviarReserva() async {
    final user = context.read<UserProvider>().user;
    if (_pistaId == null || _fecha.isEmpty || _hora.isEmpty) {
      setState(() => _error = "Rellena pista, fecha y hora.");
      return;
    }

    try {
      await context.read<ReservaProvider>().crearReservaSeguro(
        user!.id!,
        _pistaId!,
        _fecha,
        _hora,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Widget _buildLabel(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14)),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xCCA6A6C5)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }
}