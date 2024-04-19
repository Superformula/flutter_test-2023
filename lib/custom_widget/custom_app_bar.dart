import 'package:flutter/material.dart';
import 'package:restaurantour/common/constants.dart';
import 'package:restaurantour/common/extensions.dart';

AppBar getCustomAppBar(
    BuildContext context,
    String? title, {
      List<Widget>? actions,
      bool forceMaterialTransparency = true,
      Widget? leading,
      PreferredSizeWidget? bottom,
      Alignment? titleAlignment,
    }) {
  return AppBar(
    leading: leading,
    title: Align(
      alignment: titleAlignment ?? Alignment.centerLeft,
      child: Text(
        title ?? kEmptyString,
        style: context.theme.textTheme.headlineSmall?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    forceMaterialTransparency: forceMaterialTransparency,
    actions: actions,
    bottom: bottom,
  );
}