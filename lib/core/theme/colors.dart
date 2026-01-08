import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF1e3c72); // Deep Blue
  static const Color primaryLight = Color(0xFF2a5298); // Lighter Blue
  static const Color indigo = Color(0xFF6366F1); // Indigo
  static const Color indigoDark = Color(0xFF4F46E5); // Darker Indigo

  // Secondary/Accent Colors
  static const Color amber = Color(0xFFF59E0B); // Rating/Warning
  static const Color red = Color(0xFFEF4444); // Error
  static const Color green = Color(0xFF10B981); // Success

  // Background Colors
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color bgDark = Color(0xFF0F172A);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E293B);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1E293B); // Dark Blue/Grey for Light Mode
  static const Color textSecondaryLight = Color(0xFF64748B); // Grey for Light Mode
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Colors.white70;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient indigoGradient = LinearGradient(
    colors: [indigo, indigoDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
