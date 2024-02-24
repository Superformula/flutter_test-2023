import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/app/l10n/l10n.dart';
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
    final l10n = context.l10n;

    var text = l10n.openNow;
    var color = colors.open ?? Colors.green;

    if (!isOpenNow) {
      text = l10n.closed;
      color = colors.closed ?? Colors.red;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: typography.overline?.copyWith(height: 1.2),
        ),
        const SizedBox(width: Spacing.sm),
        Circle(
          color: color,
          size: Spacing.sm,
        ),
      ],
    );
  }
}
