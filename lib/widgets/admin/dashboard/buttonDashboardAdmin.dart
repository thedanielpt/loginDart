// lib/widgets/button_menu_admin.dart
import 'package:flutter/material.dart';

class ButtonMenuAdmin extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool danger;

  const ButtonMenuAdmin({
    super.key,
    required this.text,
    required this.onPressed,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: danger ? Colors.red : Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
