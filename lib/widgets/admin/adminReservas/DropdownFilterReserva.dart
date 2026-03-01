import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/PistaProvider.dart';


class DropdownFilterPistas extends StatelessWidget {
  final String valueLabel;

  final void Function(String label, String? pistaId) onChanged;

  const DropdownFilterPistas({
    super.key,
    required this.valueLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final pistas = context.watch<PistaProvider>().pistas;

    // Construye items: TODAS + pistas
    final items = <_PistaDropdownItem>[
      const _PistaDropdownItem(label: "TODAS", pistaId: null),
      ...pistas.map((p) => _PistaDropdownItem(label: p.nombre, pistaId: p.id)),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFF0F172A),
          value: valueLabel,
          iconEnabledColor: Colors.white,
          isExpanded: true,
          style: const TextStyle(color: Colors.white),
          items: items
              .map(
                (it) => DropdownMenuItem<String>(
              value: it.label,
              child: Text(it.label),
            ),
          )
              .toList(),
          onChanged: (newLabel) {
            if (newLabel == null) return;
            final match = items.firstWhere((e) => e.label == newLabel);
            onChanged(match.label, match.pistaId);
          },
        ),
      ),
    );
  }
}

class _PistaDropdownItem {
  final String label;
  final String? pistaId;
  const _PistaDropdownItem({required this.label, required this.pistaId});
}