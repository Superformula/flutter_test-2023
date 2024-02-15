import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final openSans12 = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static final openSans14 = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static final openSans16 = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static final lora16 = GoogleFonts.lora(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static final lora18 = GoogleFonts.lora(
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static final lora28 = GoogleFonts.lora(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
}
