import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/widgets/widgets.dart';

class RestaurantStatus extends StatelessWidget {
  const RestaurantStatus({
    required this.isOpenNow,
    super.key,
  });

  final bool isOpenNow;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;
    final colors = appTheme.colors;

    var text = 'Open Now';
    var color = colors.open ?? Colors.green;

    if (!isOpenNow) {
      text = 'Closed';
      color = colors.closed ?? Colors.red;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: typography.overline?.copyWith(height: 1.2),
        ),
        const SizedBox(width: 8),
        Circle(
          color: color,
          size: 8,
        ),
      ],
    );
  }
}
