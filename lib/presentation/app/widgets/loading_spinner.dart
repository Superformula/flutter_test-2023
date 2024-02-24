import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    Key? key,
    this.color,
    this.strokeWidth = 2.0,
    this.size = 40.0,
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
