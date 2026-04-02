import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    // Light: A soft, warm amber "ambient" tint
    // Dark: A deep, rich midnight blue
    final Color bgColor = isDark
        ? const Color(0xFF0A192F) // Deep Blue
        : const Color(0xFFFFFBEB); // Light Amber Ambient (Surface-like)

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.amber,
        brightness: brightness,
        // Force the primary color to be exactly what you want
        primary: isDark ? Colors.amber.shade300 : Colors.amber.shade800,
      ),

      scaffoldBackgroundColor: bgColor,

      appBarTheme: AppBarTheme(
        backgroundColor: bgColor,
        surfaceTintColor:
            Colors.transparent, // Prevents M3 purple tint on scroll
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      cardTheme: CardThemeData(
        // In M3, cards look better using the generated Surface Container colors
        color: isDark ? const Color(0xFF112240) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),

      // Optional: Ensure text contrast is sharp against the ambient background
      textTheme: const TextTheme(bodyMedium: TextStyle(letterSpacing: 0.2)),
    );
  }

  static final lightTheme = _buildTheme(Brightness.light);
  static final darkTheme = _buildTheme(Brightness.dark);
}
