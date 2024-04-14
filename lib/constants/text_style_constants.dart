import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStylesClass {
  //Lora's font common text styles
  //basic text style for titles
  static final TextStyle titleTextStyle =
      GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold);

  //basic text style for titles
  static final TextStyle restaurantCardTitleTextStyle =
      GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.w500);

  //Open Sans' font common text styles
  //basic text style for titles
  static final TextStyle subtitlesTextStyle =
      GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600);

  static final TextStyle priceCategoryTextStyle =
      GoogleFonts.openSans(fontSize: 12);

  static final TextStyle captionTextStyle =
      GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400);

  static final TextStyle openCloseRestaurantTextStyle = GoogleFonts.openSans(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static final TextStyle reviewRestaurantTextStyle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle restaurantAddressTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}
