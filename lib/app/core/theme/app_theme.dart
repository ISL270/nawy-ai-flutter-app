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
  static const Color _brightBlue = Color(0xFF0169A1);
  static const Color _vibrantOrange = Color(0xFFFC5600);
  static const Color _neutralBlack = Color(0xFF000000);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _lightGrey = Color(0xFFEEEEEE);

  /// Light Theme Configuration
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: _brightBlue,
      onPrimary: _white,
      secondary: _vibrantOrange,
      onSecondary: _white,
      tertiary: _vibrantOrange,
      onTertiary: _white,
      surface: _white,
      onSurface: _neutralBlack,
      surfaceContainerHighest: _lightGrey,
    ),

    // Text Theme - Black text by default
    textTheme: const TextTheme().apply(bodyColor: _neutralBlack, displayColor: _neutralBlack),
  );
}
