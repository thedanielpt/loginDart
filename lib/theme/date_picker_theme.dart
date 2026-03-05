import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData buildDatePickerTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    dialogBackgroundColor: AppColors.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onPrimary: AppColors.dark,
      surface: AppColors.dark,
      onSurface: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
  );
}
