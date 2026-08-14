import 'package:flutter/material.dart';

abstract final class AppColors {
  static const sky = Color(0xFFEAF9FF);
  static const ink = Color(0xFF143A62);
  static const blue = Color(0xFF32B8F2);
  static const orange = Color(0xFFFF9727);
  static const purple = Color(0xFF8C5ADD);
  static const green = Color(0xFF78CB2C);
}

abstract final class LearningAcademyTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.sky,
      fontFamily: 'Arial',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.ink,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.2,
        ),
        titleLarge: TextStyle(fontWeight: FontWeight.w900),
        bodyLarge: TextStyle(color: AppColors.ink, fontWeight: FontWeight.w600),
      ),
    );
  }
}
