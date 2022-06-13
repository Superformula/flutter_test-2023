import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class AppPlaceHolder extends StatelessWidget {
  final double height;
  final double? width;

  AppPlaceHolder({required this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColor.placeHolder,
      ),
    );
  }
}
