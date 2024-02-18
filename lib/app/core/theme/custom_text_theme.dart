import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CustomTextTheme {
  //Text
  static final textTheme = TextTheme(
    //Title
    //AppBar
    titleLarge: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
    //
    titleMedium: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    //
    titleSmall: GoogleFonts.lora(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),

    //Label
    //Rating number
    labelLarge: GoogleFonts.lora(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black),
    //Selected button Restaurants
    labelMedium:
        GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
    // Pricing and open/closed, address label, rating label, reviews and usarname review label
    labelSmall:
        GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),

    //Body
    //Review text
    bodyLarge: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
    bodyMedium:
        GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
    bodySmall: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
  );
}
