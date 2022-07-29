import 'package:flutter/material.dart';
import 'package:restaurantour_ui/src/text_styles.dart';

/// Namespace for the Restaurantour [ThemeData].
class RestaurantourTheme {
  /// Standard 'ThemeData' for Restaurantour UI.
  static ThemeData get standard {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: _textTheme,
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
}
