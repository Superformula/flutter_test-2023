import 'package:flutter/cupertino.dart';

import '/resources/resources_exports.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(bool darkModeOn, BuildContext context) {
  return ThemeData(
    //main colors
    brightness: (darkModeOn) ? Brightness.dark : Brightness.light,
    primaryColor: ColorManager.white,
    primaryColorDark: ColorManager.black60,
    primaryColorLight: ColorManager.black5,
    disabledColor: ColorManager.grey1,
    indicatorColor: ColorManager.black,

    //card theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.size8.r)),
    ),
    //appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.white,
      elevation: 4,
      shadowColor: ColorManager.black20,
      titleTextStyle: getRegularTextStyle(
        fontSize: FontSize.s16,
        color: ColorManager.black,
      ),
    ),
    //scaffold theme
    scaffoldBackgroundColor: (darkModeOn) ? ColorManager.black : ColorManager.black5,
    //button theme
    buttonTheme: ButtonThemeData(
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.black,
      shape: StadiumBorder(
        side: BorderSide(color: ColorManager.white, width: 2.w),
      ),
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(color: ColorManager.black80),
        backgroundColor: ColorManager.black,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: ColorManager.black,
        foregroundColor: ColorManager.black80,
      ),
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldTextStyle(
        color: ColorManager.black80,
        fontSize: FontSize.s16.sp,
      ),
      titleMedium: getMediumTextStyle(
        color: ColorManager.black60,
        fontSize: FontSize.s14.sp,
      ),
      bodySmall: getRegularTextStyle(color: ColorManager.grey1),
      bodyLarge: getRegularTextStyle(color: ColorManager.grey1),
    ),
    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getLightTextStyle(
        color: ColorManager.black60,
        fontSize: FontSize.s14.sp,
      ),
      labelStyle: getRegularTextStyle(
        color: ColorManager.black80,
        fontSize: FontSize.s16.sp,
      ),
      errorStyle: getLightTextStyle(color: ColorManager.error),
      filled: true,
      fillColor: ColorManager.black5,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
    ),
    //slider theme
    sliderTheme: SliderTheme.of(context).copyWith(
      trackHeight: 4.0,
      thumbColor: ColorManager.black,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
      overlayColor: null,
      activeTickMarkColor: ColorManager.black5,
      activeTrackColor: ColorManager.black5,
      inactiveTickMarkColor: ColorManager.black80,
      inactiveTrackColor: ColorManager.black80,
    ),
    //icon theme
    iconTheme: IconThemeData(
      color: ColorManager.black,
    ),
    // circular progress indicator theme
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: ColorManager.black,
    ),
  );
}
