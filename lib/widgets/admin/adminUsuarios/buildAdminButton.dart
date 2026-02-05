import 'package:flutter/material.dart';

class ButtonAdminUser extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final bool fullWidth;

  const ButtonAdminUser({
    super.key,
    required this.text,
    required this.onClick,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: fullWidth ? double.infinity : null,
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xCC2C2C54),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xCCA6A6C5),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}