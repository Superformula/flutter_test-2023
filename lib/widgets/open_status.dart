import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class OpenStatus extends StatelessWidget {
  final bool isOpen;
  const OpenStatus(this.isOpen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isOpen ? "Open Now" : "Closed",
          style: Theme.of(context).textTheme.overline,
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.circle,
          color: isOpen ? AppColors.open : AppColors.closed,
          size: 12.0,
        ),
      ],
    );
  }
}
