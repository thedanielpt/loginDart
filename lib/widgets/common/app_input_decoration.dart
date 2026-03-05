import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

InputDecoration appInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.white38),
    filled: true,
    fillColor: Colors.transparent,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.borderSoft),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}
