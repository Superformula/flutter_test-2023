import '/resources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, fontWeight: fontWeight, color: color);
}

TextStyle getLightTextStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstant.fontFamily, FontWeightManager.light, color);
}

TextStyle getRegularTextStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstant.fontFamily, FontWeightManager.regular, color);
}

TextStyle getMediumTextStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstant.fontFamily, FontWeightManager.medium, color);
}

TextStyle getSemiBoldTextStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstant.fontFamily, FontWeightManager.semiBold, color);
}

TextStyle getBoldTextStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstant.fontFamily, FontWeightManager.bold, color);
}
