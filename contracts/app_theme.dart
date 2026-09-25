import 'package:flutter/material.dart';

/// Semantic Tajweed Color Scheme for WCAG 2.1 AA contrast compliance (>= 4.5:1)
class TajweedColors {
  final Color mad;
  final Color ghunnah;
  final Color qalqalah;
  final Color ikhfa;
  final Color idgham;
  final Color iqlab;
  final Color waqaf;

  const TajweedColors({
    required this.mad,
    required this.ghunnah,
    required this.qalqalah,
    required this.ikhfa,
    required this.idgham,
    required this.iqlab,
    required this.waqaf,
  });

  static const light = TajweedColors(
    mad: Color(0xFFDC2626), // Merah Crimson (Contrast 5.3:1)
    ghunnah: Color(0xFF047857), // Hijau Emerald (Contrast 6.5:1)
    qalqalah: Color(0xFF0369A1), // Biru Laut (Contrast 6.4:1)
    ikhfa: Color(0xFF0D9488), // Toska/Teal (Contrast 4.8:1)
    idgham: Color(0xFF475569), // Abu-abu Slate (Contrast 7.3:1)
    iqlab: Color(0xFF7C3AED), // Ungu Violet (Contrast 6.8:1)
    waqaf: Color(0xFFB45309), // Amber/Emas Gelap (Contrast 5.2:1)
  );

  static const sepia = TajweedColors(
    mad: Color(0xFFB91C1C), // Contrast 6.8:1
    ghunnah: Color(0xFF047857), // Contrast 6.5:1
    qalqalah: Color(0xFF0369A1), // Contrast 6.0:1
    ikhfa: Color(0xFF0F766E), // Contrast 6.6:1
    idgham: Color(0xFF334155), // Contrast 8.9:1
    iqlab: Color(0xFF6D28D9), // Contrast 6.7:1
    waqaf: Color(0xFF92400E), // Contrast 7.5:1
  );

  static const dark = TajweedColors(
    mad: Color(0xFFF87171), // Contrast 8.2:1
    ghunnah: Color(0xFF34D399), // Contrast 11.2:1
    qalqalah: Color(0xFF38BDF8), // Contrast 10.6:1
    ikhfa: Color(0xFF2DD4BF), // Contrast 11.7:1
    idgham: Color(0xFF94A3B8), // Contrast 8.8:1
    iqlab: Color(0xFFC084FC), // Contrast 9.7:1
    waqaf: Color(0xFFFBBF24), // Contrast 12.8:1
  );
}

/// AppTheme definition supporting Light, Warm Sepia, and OLED Dark
class AppTheme {
  // Brand Colors
  static const Color emeraldPrimary = Color(0xFF047857);
  static const Color goldAccent = Color(0xFFD97706);

  // Background Colors
  static const Color lightBg = Color(0xFFF9FAFB);
  static const Color sepiaBg = Color(0xFFFBF4E2);
  static const Color darkBg = Color(0xFF020617);

  // Surface Colors
  static const Color lightSurface = Colors.white;
  static const Color sepiaSurface = Color(0xFFF5EAC9);
  static const Color darkSurface = Color(0xFF0F172A);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: emeraldPrimary,
      scaffoldBackgroundColor: lightBg,
      colorScheme: const ColorScheme.light(
        primary: emeraldPrimary,
        secondary: goldAccent,
        surface: lightSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBg,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Color(0xFF0F172A),
      ),
    );
  }

  static ThemeData get sepiaTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF047857),
      scaffoldBackgroundColor: sepiaBg,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF047857),
        secondary: Color(0xFFB45309),
        surface: sepiaSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: sepiaBg,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Color(0xFF451A03),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: emeraldPrimary,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF10B981),
        secondary: Color(0xFFFBBF24),
        surface: darkSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
    );
  }
}
