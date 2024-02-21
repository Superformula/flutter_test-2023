import '/resources/resources_exports.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(bool darkModeOn, BuildContext context) {
  return ThemeData(
    //main colors
    brightness: (darkModeOn) ? Brightness.dark : Brightness.light,
    primaryColor: ColorManager.primary,
    primaryColorDark: ColorManager.darkPrimary,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primaryOpacity70,
    //card theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.size8.r)),
    ),
    //appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: 4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getRegularTextStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
    ),
    //scaffold theme
    scaffoldBackgroundColor: (darkModeOn) ? ColorManager.black : ColorManager.black5,
    //button theme
    buttonTheme: ButtonThemeData(
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
      shape: StadiumBorder(
        side: BorderSide(color: ColorManager.white, width: 2.w),
      ),
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
      ),
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldTextStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16.sp,
      ),
      titleMedium: getMediumTextStyle(
        color: ColorManager.ligthGrey,
        fontSize: FontSize.s14.sp,
      ),
      bodySmall: getRegularTextStyle(color: ColorManager.grey1),
      bodyLarge: getRegularTextStyle(color: ColorManager.grey1),
    ),
    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getLightTextStyle(
        color: ColorManager.ligthGrey,
        fontSize: FontSize.s14.sp,
      ),
      labelStyle: getRegularTextStyle(
        color: ColorManager.darkGrey,
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
      thumbColor: ColorManager.primary,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
      overlayColor: null,
      activeTickMarkColor: ColorManager.primary,
      activeTrackColor: ColorManager.primary,
      inactiveTickMarkColor: ColorManager.primary90,
      inactiveTrackColor: ColorManager.primary90,
    ),
  );
}
