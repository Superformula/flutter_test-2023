import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';

extension ThemeExtensionHelper on BuildContext {
  RestauranTourTheme get theme =>
      Theme.of(this).extension<RestauranTourTheme>()!;
}
