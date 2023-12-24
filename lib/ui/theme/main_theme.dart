import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

const int _textColor = 0xFF64748B;
const MaterialColor textSwatch = MaterialColor(_textColor, <int, Color>{
  50: Color(0xFFF8FAFC),
  100: Color(0xFFF1F5F9),
  200: Color(0xFFE2E8F0),
  300: Color(0xFFCBD5E1),
  400: Color(0xFF94A3B8),
  500: Color(_textColor),
  600: Color(0xFF475569),
  700: Color(0xFF334155),
  800: Color(0xFF1E293B),
  900: Color(0xFF0F172A),
});

const Color primaryColor = Color(0xFF2B637B);
const Color errorColor = Color(0xFFDC2626); // red-600

final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF2B637B),
    colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        onSecondary: Colors.white,
        error: errorColor,
        background: textSwatch.shade200,
        onBackground: textSwatch.shade500,
        onSurface: textSwatch.shade500,
        surface: textSwatch.shade50,
        surfaceVariant: Colors.white,
        shadow: textSwatch.shade900.withOpacity(.1)),
    fontFamily: GoogleFonts.nunito().fontFamily,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.nunito(
        color: textSwatch.shade700,
      ),
      displayMedium: GoogleFonts.nunito(
        color: textSwatch.shade600,
      ),
      displaySmall: GoogleFonts.nunito(
        color: textSwatch.shade500,
      ),
      headlineLarge: GoogleFonts.nunito(
        color: textSwatch.shade700,
      ),
      headlineMedium: GoogleFonts.nunito(
        color: textSwatch.shade600,
      ),
      headlineSmall: GoogleFonts.nunito(
        color: textSwatch.shade500,
      ),
      titleLarge: GoogleFonts.nunito(
        color: textSwatch.shade700,
      ),
      titleMedium: GoogleFonts.nunito(
        color: textSwatch.shade600,
      ),
      titleSmall: GoogleFonts.nunito(
        color: textSwatch.shade500,
      ),
      bodyLarge: GoogleFonts.nunito(
        color: textSwatch.shade700,
      ),
      bodyMedium: GoogleFonts.nunito(
        color: textSwatch.shade600,
      ),
      bodySmall: GoogleFonts.nunito(
        color: textSwatch.shade500,
      ),
      labelLarge: GoogleFonts.nunito(
        color: textSwatch.shade700,
      ),
      labelMedium: GoogleFonts.nunito(
        color: textSwatch.shade600,
      ),
      labelSmall: GoogleFonts.nunito(
        color: textSwatch.shade500,
      ),
    ));

final themeProvider = StateProvider<ThemeData>((ref) {
  return lightTheme;
});
