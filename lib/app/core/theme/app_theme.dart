import 'package:flutter/material.dart';

/// Nawy App Theme Configuration
///
/// Brand Colors:
/// - Primary: #0169A1 (Bright Blue)
/// - Secondary: #FC5600 (Vibrant Orange)
/// - Support: #7AC7BD (Teal)
/// - Neutral: #000000 (Black)
class AppTheme {
  // Brand Colors
  static const Color brightBlue = Color(0xFF0169A1);
  static const Color vibrantOrange = Color(0xFFFC5600);
  static const Color neutralBlack = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  /// Light Theme Configuration
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: brightBlue,
      onPrimary: white,
      secondary: vibrantOrange,
      onSecondary: white,
      tertiary: vibrantOrange,
      onTertiary: white,
      surface: white,
      onSurface: neutralBlack,
    ),

    // Text Theme - Black text by default
    textTheme: const TextTheme().apply(bodyColor: neutralBlack, displayColor: neutralBlack),
  );
}
