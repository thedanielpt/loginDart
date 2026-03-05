import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/ReservaProvider.dart';
import '../../provider/UserProvider.dart';

import '../../theme/app_colors.dart';
import '../../theme/date_picker_theme.dart';
import '../../utils/app_assets.dart';
import '../../utils/reserva_constants.dart';
import '../../widgets/common/app_background.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/form_label.dart';
import '../../widgets/common/app_input_decoration.dart';

class CrearReservaPorJugador extends StatefulWidget {
  const CrearReservaPorJugador({super.key});

  @override
  State<CrearReservaPorJugador> createState() => _CrearReservaPorJugadorState();
}

class _CrearReservaPorJugadorState extends State<CrearReservaPorJugador> {
  int _selectedTab = 0;

  String? _pistaId;
  String _fecha = "";
  String _hora = "";
  String? _error;

  @override
  Widget build(BuildContext context) {
    final reservaProvider = context.watch<ReservaProvider>();

    final horasDisponibles = ReservaConstants.horas
        .where((h) => !reservaProvider.horasOcupadas.contains(h))
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        backgroundColor: AppColors.dark,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.white60,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedTab = index);
          if (index == 1) {
            Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), label: 'Salir'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
      body: AppBackground(
        asset: AppAssets.bgRafa,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Crear Reserva",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),

                  if (_error != null) ...[
                    Text(
                      _error!,
                      style: const TextStyle(color: AppColors.errorSoft),
                    ),
                    const SizedBox(height: 10),
                  ],

                  const FormLabel("Pista"),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppColors.dark,
                    style: const TextStyle(color: Colors.white),
                    value: _pistaId,
                    decoration: appInputDecoration("Selecciona una pista"),
                    items: ReservaConstants.pistas.map((id) {
                      return DropdownMenuItem(
                        value: id,
                        child: Text("Pista $id"),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _pistaId = val;
                        _hora = "";
                      });
                      _checkHorasOcupadas();
                    },
                  ),

                  const SizedBox(height: 12),

                  const FormLabel("Fecha"),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2027),
                        builder: (context, child) {
                          return Theme(
                            data: buildDatePickerTheme(context),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null) {
                        setState(() {
                          _fecha = picked.toString().substring(0, 10);
                          _hora = "";
                        });
                        _checkHorasOcupadas();
                      }
                    },
                    child: InputDecorator(
                      decoration: appInputDecoration("Elegir fecha"),
                      child: Text(
                        _fecha.isEmpty ? "Elegir" : _fecha,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const FormLabel("Hora"),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppColors.dark,
                    style: const TextStyle(color: Colors.white),
                    value: _hora.isEmpty ? null : _hora,
                    decoration: appInputDecoration("Selecciona hora"),
                    items: (_pistaId == null || _fecha.isEmpty)
                        ? const [
                            DropdownMenuItem<String>(
                              value: null,
                              enabled: false,
                              child: Text("Elige pista y fecha primero"),
                            )
                          ]
                        : horasDisponibles.map((h) {
                            return DropdownMenuItem(value: h, child: Text(h));
                          }).toList(),
                    onChanged: (val) => setState(() => _hora = val ?? ""),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: AppColors.borderSoft),
                        ),
                      ),
                      onPressed: _enviarReserva,
                      child: const Text(
                        "Crear Reserva",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkHorasOcupadas() {
    if (_pistaId != null && _fecha.isNotEmpty) {
      context.read<ReservaProvider>().cargarHorasOcupadas(_fecha, _pistaId!);
    }
  }

  Future<void> _enviarReserva() async {
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
}
