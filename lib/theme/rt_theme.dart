import 'package:flutter/material.dart';
import 'package:restaurantour/theme/rt_colors.dart';

class RTThemeData {
  static get _themeExtension => RTThemeExtension(
        openColor: RTColors.open,
        closedColor: RTColors.closed,
        backgroundColor: RTColors.background,
        placeholderColor: RTColors.placeholder,
        whiteColor: RTColors.white,
        dividerLineColor: RTColors.dividerLine,
        primaryFillColor: RTColors.primaryFill,
        defaultTextColor: RTColors.defaultText,
        secondaryTextColor: RTColors.secondaryText,
      );

  static final themeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 2,
      centerTitle: true,
      surfaceTintColor: RTColors.background,
      shadowColor: RTColors.primaryFill,
    ),
    colorScheme: const ColorScheme.light(
      primary: RTColors.primaryFill,
      onSurface: RTColors.secondaryText,
      background: RTColors.background,
    ),
    extensions: [
      _themeExtension,
    ],
  );
}

class RTThemeExtension extends ThemeExtension<RTThemeExtension> {
  RTThemeExtension({
    required this.openColor,
    required this.closedColor,
    required this.backgroundColor,
    required this.placeholderColor,
    required this.whiteColor,
    required this.dividerLineColor,
    required this.primaryFillColor,
    required this.defaultTextColor,
    required this.secondaryTextColor,
  });

  final Color openColor;
  final Color closedColor;
  final Color backgroundColor;
  final Color placeholderColor;
  final Color whiteColor;
  final Color dividerLineColor;
  final Color primaryFillColor;
  final Color defaultTextColor;
  final Color secondaryTextColor;

  @override
  ThemeExtension<RTThemeExtension> copyWith({
    Color? openColor,
    Color? closedColor,
    Color? backgroundColor,
    Color? placeholderColor,
    Color? whiteColor,
    Color? dividerLineColor,
    Color? primaryFillColor,
    Color? defaultTextColor,
    Color? secondaryTextColor,
  }) {
    return RTThemeExtension(
      openColor: openColor ?? this.openColor,
      closedColor: closedColor ?? this.closedColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      whiteColor: whiteColor ?? this.whiteColor,
      dividerLineColor: dividerLineColor ?? this.dividerLineColor,
      primaryFillColor: primaryFillColor ?? this.primaryFillColor,
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
    );
  }

  @override
  ThemeExtension<RTThemeExtension> lerp(covariant ThemeExtension<RTThemeExtension>? other, double t) {
    if (other is! RTThemeExtension) {
      return this;
    }

    return RTThemeExtension(
      openColor: Color.lerp(openColor, other.openColor, t)!,
      closedColor: Color.lerp(closedColor, other.closedColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      placeholderColor: Color.lerp(placeholderColor, other.placeholderColor, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      dividerLineColor: Color.lerp(dividerLineColor, other.dividerLineColor, t)!,
      primaryFillColor: Color.lerp(primaryFillColor, other.primaryFillColor, t)!,
      defaultTextColor: Color.lerp(defaultTextColor, other.defaultTextColor, t)!,
      secondaryTextColor: Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
    );
  }
}
