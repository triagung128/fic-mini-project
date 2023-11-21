import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

const Color blueColor = Color(0xFF1A72DD);
const Color navyColor = Color(0xFF2A3256);
const Color whiteColor = Color(0xFFFFFFFF);
const Color greyColor = Color(0xFFF7F8FA);

final textTheme = TextTheme(
  displayLarge: GoogleFonts.rubik(
    fontSize: 98,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: navyColor,
  ),
  displayMedium: GoogleFonts.rubik(
    fontSize: 61,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: navyColor,
  ),
  displaySmall: GoogleFonts.rubik(
    fontSize: 49,
    fontWeight: FontWeight.w400,
    color: navyColor,
  ),
  headlineMedium: GoogleFonts.rubik(
    fontSize: 35,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: navyColor,
  ),
  headlineSmall: GoogleFonts.rubik(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: navyColor,
  ),
  titleLarge: GoogleFonts.rubik(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: navyColor,
  ),
  titleMedium: GoogleFonts.rubik(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: navyColor,
  ),
  titleSmall: GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: navyColor,
  ),
  bodyLarge: GoogleFonts.rubik(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: navyColor,
  ),
  bodyMedium: GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: navyColor,
  ),
  labelLarge: GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: whiteColor,
  ),
  bodySmall: GoogleFonts.rubik(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: navyColor,
  ),
  labelSmall: GoogleFonts.rubik(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: navyColor,
  ),
);
