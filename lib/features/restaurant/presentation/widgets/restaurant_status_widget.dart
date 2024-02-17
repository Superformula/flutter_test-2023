import 'package:flutter/material.dart';
import 'package:restaurantour/common/ui/app_colors.dart';

class RestaurantStatusWidget extends StatelessWidget {
  const RestaurantStatusWidget({
    Key? key,
    required this.isOpen,
  }) : super(key: key);

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isOpen ? 'Open Now' : 'Closed',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.circle,
          size: 8,
          color: isOpen
              ? AppColors.kWetFrogGreen
              : AppColors.kPseudoStrawberryPink,
        ),
      ],
    );
  }
}
