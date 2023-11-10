import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFBFF11), brightness: Brightness.dark);

ThemeData getDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kDarkColorScheme.primaryContainer,
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
    ),
    cardTheme: const CardTheme().copyWith(
      color: kDarkColorScheme.onPrimaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.onPrimaryContainer,
        foregroundColor: kDarkColorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
      ),
    ),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      titleSmall: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
