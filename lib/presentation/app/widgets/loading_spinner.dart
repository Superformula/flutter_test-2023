import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    Key? key,
    this.color,
    this.strokeWidth = Spacing.xxs,
    this.size = Spacing.xxlg,
  }) : super(key: key);

  final Color? color;
  final double strokeWidth;
  final double size;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final colors = appTheme.colors;
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color ?? colors.black,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
