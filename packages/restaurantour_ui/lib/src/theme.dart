import 'package:flutter/material.dart';
import 'package:restaurantour_ui/src/text_styles.dart';

import 'colors.dart';

/// Namespace for the Restaurantour [ThemeData].
class RestaurantourTheme {
  /// Standard 'ThemeData' for Restaurantour UI.
  static ThemeData get standard {
    return ThemeData(
      primaryColor: RestaurantourColors.primaryFill,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      scaffoldBackgroundColor: RestaurantourColors.background,
      tabBarTheme: _tabBarTheme,
      cardTheme: _cardTheme,
      colorScheme: const ColorScheme.light().copyWith(
        primary: RestaurantourColors.primaryFill,
        surface: RestaurantourColors.surface,
      ),
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headline6: RestaurantourTextStyle.headline6,
      headline4: RestaurantourTextStyle.headline4,
      subtitle1: RestaurantourTextStyle.subtitle1,
      bodyText1: RestaurantourTextStyle.body1,
      bodyText2: RestaurantourTextStyle.body2,
      button: RestaurantourTextStyle.button,
      caption: RestaurantourTextStyle.caption,
      overline: RestaurantourTextStyle.overline,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      color: RestaurantourColors.surface,
      iconTheme: const IconThemeData(color: RestaurantourColors.primaryFill),
      titleTextStyle: RestaurantourTextStyle.headline6,
    );
  }

  static TabBarTheme get _tabBarTheme {
    return const TabBarTheme(
      labelColor: RestaurantourColors.defaultText,
      unselectedLabelColor: RestaurantourColors.secondaryText,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2,
          color: RestaurantourColors.primaryFill,
        ),
      ),
    );
  }

  static CardTheme get _cardTheme {
    return CardTheme(
      margin: EdgeInsets.zero,
      color: RestaurantourColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
