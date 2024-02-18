import 'package:flutter/material.dart';

import 'custom_text_theme.dart';

abstract class CustomAppBarTheme {
  static final appBarTheme = AppBarTheme(
    centerTitle: true,
    titleTextStyle: CustomTextTheme.textTheme.titleLarge,
    backgroundColor: Colors.white,
    elevation: 20,
  );
}
