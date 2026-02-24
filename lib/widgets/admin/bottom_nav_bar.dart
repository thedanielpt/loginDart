import 'package:flutter/material.dart';

class BottomNavItem {
  final String label;
  final IconData icon;
  final String? route;

  const BottomNavItem({
    required this.label,
    required this.icon,
    this.route,
  });
}

class BottomNavBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;
  final List<BottomNavItem> items;

  const BottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: const Color(0xFF1A1A40),
      elevation: 0,
      selectedIndex: selectedTab,
      indicatorColor: const Color(0xFF2C2C54),

      // 👇 FORZAMOS TEXTO BLANCO
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
      ),

      onDestinationSelected: (index) {
        onTabSelected(index);

        final route = items[index].route;

        if (route != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(route, (route) => false);
        }
      },

      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(
            item.icon,
            color: Colors.white,
          ),
          selectedIcon: Icon(
            item.icon,
            color: Colors.white,
          ),
          label: item.label,
        );
      }).toList(),
    );
  }
}