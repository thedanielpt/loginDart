import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class FormLabel extends StatelessWidget {
  final String text;

  const FormLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.white70,
          fontSize: 14,
        ),
      ),
    );
  }
}
