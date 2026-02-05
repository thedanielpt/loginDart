import 'package:flutter/material.dart';

class DropdownFilterAdmin extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const DropdownFilterAdmin({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xCC2C2C54), // Azul oscuro con opacidad
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xCCA6A6C5), // Borde grisáceo
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF1A1A40), // Fondo del menú desplegable (sólido)
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          // Mapeamos la lista de strings a los items del menú
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}