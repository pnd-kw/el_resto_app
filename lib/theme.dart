import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(1, 235, 235, 235),
);

final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.libreBodoni(
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    headlineLarge: GoogleFonts.libreBodoni(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 20,
    ),
    titleLarge: GoogleFonts.lilyScriptOne(
      fontSize: 24,
    ),
    titleMedium: GoogleFonts.lilitaOne(
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.libreBaskerville(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    bodySmall: GoogleFonts.libreBaskerville(
      fontSize: 10,
    ),
    labelSmall: GoogleFonts.libreBaskerville(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    ));

final theme = ThemeData().copyWith(
  colorScheme: colorScheme,
  textTheme: textTheme,
);
