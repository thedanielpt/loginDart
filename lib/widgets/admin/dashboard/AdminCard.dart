import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final String title;
  final bool danger;
  final VoidCallback onTap;

  const AdminCard(
      this.title,
      this.onTap, {
        this.danger = false,
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: danger
                ? const Color(0xFF8B1E1E)
                : const Color(0xCC2C2C54), // azul translúcido
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xCCA6A6C5),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}