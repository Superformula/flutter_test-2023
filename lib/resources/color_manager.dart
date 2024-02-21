import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexaColor.fromHex("#2F6CF6");
  static Color skyBlue = HexaColor.fromHex("#E3ECFF");
  static Color success = HexaColor.fromHex("#00F033");
  static Color ligthGrey = HexaColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexaColor.fromHex("#B3262A4B");
  static Color alterPrimary = HexaColor.fromHex("#2338c7");
  static Color darkPrimary = HexaColor.fromHex("#1226AA");
  static Color darkPrimaryOpacity70 = HexaColor.fromHex("#B31226AA");
  static Color ligthPrimary = HexaColor.fromHex("#578BFF");

  static Color grey1 = HexaColor.fromHex("#525252");
  static Color grey2 = HexaColor.fromHex("#737477");
  static Color white = HexaColor.fromHex("#FFFFFF");
  static Color black = HexaColor.fromHex("#000000");
  static Color error = HexaColor.fromHex("#FB4E4E");

  static Color black5 = HexaColor.fromHex("#F9F9FA");
  static Color black80 = HexaColor.fromHex("#1E2135");
  static Color black60 = HexaColor.fromHex("#A0A4A8");
  static Color black50 = HexaColor.fromHex("#99000000");
  static Color black30 = HexaColor.fromHex("#4D000000");
  static Color black20 = HexaColor.fromHex("#33000000");
  static Color black10 = HexaColor.fromHex("#1A000000");

  static Color yellow = HexaColor.fromHex("#EDB225");
  static Color yellow2 = HexaColor.fromHex("#ECD037");
  static Color blue = HexaColor.fromHex("#3E7AD6");

  static Color lila = HexaColor.fromHex("#DACCFB");
  // static Color purple = HexaColor.fromHex("#997F71F6");
  static Color purple = HexaColor.fromHex("#7F71F6");
  static Color grey60 = HexaColor.fromHex('#99999BAB');

  static Color pink = HexaColor.fromHex("#E5B5B4");
  static Color orange = HexaColor.fromHex("#FFA800");
  static Color darkGrey = HexaColor.fromHex("#39373B");
  static Color darkBlue = HexaColor.fromHex('#060A21');
  static Color spaceBlue = HexaColor.fromHex('#1F1B2F');

  static Color gradientPrimary = HexaColor.fromHex("#1226AA");
  static Color gradientSecond = HexaColor.fromHex("#263CCD");

  static Color primary90 = HexaColor.fromHex("#C9D9FC");
  static Color primary40 = HexaColor.fromHex("#A3BFFF");
  static Color primary10 = HexaColor.fromHex('#E3ECFF');

  static Color innerEarthColor = HexaColor.fromHex('#0664FA66');
  static Color outerEarthColor = HexaColor.fromHex('#0556DD66');

  static Color secondBoxLight = HexaColor.fromHex('#0555DD');
  static Color secondBoxDark = HexaColor.fromHex('#020915');
  static Color secondBoxError = HexaColor.fromHex('#C43D3D');
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
