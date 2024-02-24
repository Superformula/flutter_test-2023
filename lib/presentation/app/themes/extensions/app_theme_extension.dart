import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';

class RestauranTourTheme extends ThemeExtension<RestauranTourTheme> {
  RestauranTourTheme({
    required this.typography,
    required this.colors,
  });

  final AppColors colors;
  final AppTypography typography;

  @override
  ThemeExtension<RestauranTourTheme> copyWith({
    AppColors? colors,
    AppTypography? typography,
  }) {
    return RestauranTourTheme(
      typography: typography ?? this.typography,
      colors: colors ?? this.colors,
    );
  }

  @override
  ThemeExtension<RestauranTourTheme> lerp(
    ThemeExtension<RestauranTourTheme>? other,
    double t,
  ) {
    if (other is! RestauranTourTheme) {
      return this;
    }
    return RestauranTourTheme(
      typography: AppTypography(
        headingH6: TextStyle.lerp(
          typography.headingH6,
          other.typography.headingH6,
          t,
        ),
        button: TextStyle.lerp(
          typography.button,
          other.typography.button,
          t,
        ),
        subtitle1: TextStyle.lerp(
          typography.subtitle1,
          other.typography.subtitle1,
          t,
        ),
        subtitle2: TextStyle.lerp(
          typography.subtitle2,
          other.typography.subtitle2,
          t,
        ),
        caption1: TextStyle.lerp(
          typography.caption1,
          other.typography.caption1,
          t,
        ),
        caption2: TextStyle.lerp(
          typography.caption2,
          other.typography.caption2,
          t,
        ),
        overline: TextStyle.lerp(
          typography.overline,
          other.typography.overline,
          t,
        ),
        body1: TextStyle.lerp(
          typography.body1,
          other.typography.body1,
          t,
        ),
      ),
      colors: AppColors(
        black: Color.lerp(
          colors.black,
          other.colors.black,
          t,
        ),
        grey: Color.lerp(
          colors.grey,
          other.colors.grey,
          t,
        ),
      ),
    );
  }
}
