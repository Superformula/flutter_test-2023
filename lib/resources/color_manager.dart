import 'package:flutter/material.dart';

class ColorManager {
  static Color grey1 = HexaColor.fromHex("#525252");
  static Color grey2 = HexaColor.fromHex("#737477");
  static Color white = HexaColor.fromHex("#FFFFFF");
  static Color black = HexaColor.fromHex("#000000");

  static Color black5 = HexaColor.fromHex("#F9F9FA");
  static Color black80 = HexaColor.fromHex("#1E2135");
  static Color black60 = HexaColor.fromHex("#A0A4A8");
  static Color black50 = HexaColor.fromHex("#99000000");
  static Color black30 = HexaColor.fromHex("#4D000000");
  static Color black20 = HexaColor.fromHex("#33000000");
  static Color black10 = HexaColor.fromHex("#1A000000");

  static Color success = HexaColor.fromHex("#00F033");
  static Color error = HexaColor.fromHex("#FB4E4E");
  static Color blue = HexaColor.fromHex('#1F1B2F');
  static Color yellow = HexaColor.fromHex("#ECD037");
}

extension HexaColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse("0x$hexColorString"));
  }
}
