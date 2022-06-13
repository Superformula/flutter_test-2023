import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/theme/app_color.dart';

class IsOpen extends StatelessWidget {
  final ThemeData theme;
  final Restaurant restaurant;

  const IsOpen(this.theme, this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(isOpen() ? "Open Now" : "Closed",
          style: theme.textTheme.overline!.copyWith(
              letterSpacing: -0.5
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.circle,
            color: isOpen() ? AppColor.open : AppColor.closed,
            size: 8.0,
          ),
        ),
      ],
    );
  }

  bool isOpen() {
    if (restaurant.hours != null) {
      if (restaurant.hours!.first.isOpenNow != null) {
        if (restaurant.hours!.first.isOpenNow!) {
          return true;
        }else {
          return false;
        }
      }
    }
    return false;
  }
}