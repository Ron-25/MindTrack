import 'package:flutter/material.dart';

class AppColors {

  // Primary calming blue
  static const Color primary = Color(0xFF5FA8D3);

  // Soft secondary blue
  static const Color secondary = Color(0xFFAED9E0);

  // Accent soft aqua
  static const Color accent = Color(0xFFB8E1DD);

  // Background (very light blue/white)
  static const Color background = Color(0xFFF6FAFC);

  // Card white
  static const Color card = Color(0xFFFFFFFF);

  // Text colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);

  // Emotion colors (slightly softened)
  static const Color happy = Color(0xFFFCD34D);
  static const Color calm = Color(0xFF60A5FA);
  static const Color neutral = Color(0xFF94A3B8);
  static const Color sad = Color(0xFF93C5FD);
  static const Color anxious = Color(0xFFFCA5A5);
  static const Color angry = Color(0xFFEF4444);
  static const Color tired = Color(0xFFC7D2FE);

  // Splash gradient (very calm)
  static const LinearGradient splashGradient = LinearGradient(
    colors: <Color>[
      Color(0xFFEAF6FB),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}
