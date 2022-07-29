import 'package:flutter/material.dart';
import 'package:restaurantour_ui/src/text_styles.dart';

class AttentionStatus extends StatelessWidget {
  const AttentionStatus({Key? key, required this.text, required this.iconColor})
      : super(key: key);
  final String text;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    const double circleSize = 8;
    return Row(
      children: [
        Text(
          text,
          style: RestaurantourTextStyle.overline,
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor,
          ),
        )
      ],
    );
  }
}
