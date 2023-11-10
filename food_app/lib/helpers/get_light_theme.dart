import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

var pColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xE8CCC906),
);
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFDAD604),
);

ThemeData getLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.primaryContainer,
      foregroundColor: kColorScheme.onPrimaryContainer,
    ),
    cardTheme: const CardTheme().copyWith(
      color: kColorScheme.onPrimaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primary,
        foregroundColor: kColorScheme.onPrimary,
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
