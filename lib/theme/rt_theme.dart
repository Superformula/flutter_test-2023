import 'package:flutter/material.dart';
import 'package:restaurantour/theme/rt_colors.dart';

class RTThemeData {
  static final themeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 2,
      surfaceTintColor: RTColors.background,
      shadowColor: RTColors.primaryFill,
    ),
    colorScheme: const ColorScheme.light(
      primary: RTColors.primaryFill,
      onSurface: RTColors.secondaryText,
      background: RTColors.background,
      primaryContainer: RTColors.white,
      secondaryContainer: RTColors.placeholder,
      onPrimary: RTColors.open,
      onError: RTColors.closed,
      outline: RTColors.dividerLine,
    ),
  );
}
