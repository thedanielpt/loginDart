import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/ReservaProvider.dart';
import '../../provider/UserProvider.dart';
import '../../widgets/admin/bottom_nav_bar.dart'; // Import donde está definido BottomNavItem
import '../../widgets/home/ReservaCard.dart';
import 'CrearReservaJugadorScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  // Tu lista de navegación personalizada
  late final List<BottomNavItem> navItems = const [
    BottomNavItem(label: "Dashboard", icon: Icons.home,        route: "/homeUsers"),
    BottomNavItem(label: "Salir",     icon: Icons.exit_to_app, route: "/"),
    BottomNavItem(label: "Ajustes",   icon: Icons.settings,    route: null),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<UserProvider>().user;
      if (user != null && user.id != null) {
        context.read<ReservaProvider>().escucharReservasJugador(user.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final reservaProvider = context.watch<ReservaProvider>();
    final userProvider = context.watch<UserProvider>();
    final usuarioActual = userProvider.user;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Usamos el BottomNavigationBar mapeando tus navItems
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        backgroundColor: const Color(0xFF1A1A40),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedTab = index);
          final item = navItems[index];

          if (item.route != null) {
            if (item.route == "/") {
              // Navegación para Salir (limpia el historial)
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
            } else if (item.route != "/homeUsers") {
              // Navegación a otras rutas si no es la actual
              Navigator.pushNamed(context, item.route!);
            }
          }
        },
        items: navItems.map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.label,
        )).toList(),
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
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xCC1A1A40),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "Bienvenido, ${usuarioActual?.nombre ?? 'Jugador'}",
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const Text(
                    "Mis reservas",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xCC2C2C54),
                        side: const BorderSide(color: Color(0xCCA6A6C5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CrearReservaPorJugador()),
                        );
                      },
                      child: const Text("Crear reserva", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Expanded(
                    child: reservaProvider.isLoading
                        ? const Center(child: CircularProgressIndicator(color: Colors.white))
                        : reservaProvider.reservasJugador.isEmpty
                        ? const Center(child: Text("No tienes reservas.", style: TextStyle(color: Colors.white)))
                        : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: reservaProvider.reservasJugador.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final reserva = reservaProvider.reservasJugador[index];
                        return ReservaCard(reserva: reserva);
                      },
                    ),
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