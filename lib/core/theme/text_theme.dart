import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static const String _fontFamily = 'Lora';
  static const String _fontFamilyOpenSans = 'Open Sans';

  static const black12w400OpenSans = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: _fontFamilyOpenSans,
  );

  static const black14w400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: _fontFamily,
  );

  static const black14w400OpenSans = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: _fontFamilyOpenSans,
  );

  static const black14w600 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: _fontFamily,
  );

  static const black14w600OpenSans = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: _fontFamilyOpenSans,
  );

  static const black16w600 = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static const black18w700 = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontFamily: _fontFamily,
  );

  static const white16w600 = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static const white18w600 = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );
}
