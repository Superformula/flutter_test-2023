import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// Restaurantour Text Style Definitions.
class RestaurantourTextStyle {
  static TextStyle get headline4 {
    return GoogleFonts.lora(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: RestaurantourColors.defaultText,
    );
  }

  static TextStyle get headline6 {
    return GoogleFonts.lora(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: RestaurantourColors.defaultText,
    );
  }

  static TextStyle get subtitle1 {
    return GoogleFonts.lora(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: RestaurantourColors.defaultText,
    );
  }

  static TextStyle get body1 {
    return GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: RestaurantourColors.defaultText,
    );
  }

  static TextStyle get body2 {
    return GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: RestaurantourColors.defaultText,
    );
  }

  static TextStyle get button {
    return GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: RestaurantourColors.defaultText,
    );
  }

  static TextStyle get caption {
    return GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: RestaurantourColors.defaultText,
    );
  }

  static TextStyle get overline {
    return GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: RestaurantourColors.defaultText,
    );
  }
}
