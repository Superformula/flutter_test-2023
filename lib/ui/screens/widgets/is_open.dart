import 'package:flutter/material.dart';
import 'package:restaurantour/ui/theme/app_color.dart';
import 'package:restaurantour/ui/values/padding_values.dart';

class IsOpen extends StatelessWidget {
  final bool isOpen;

  const IsOpen({Key? key, required this.isOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isOpen ? 'Open Now' : 'Closed',
          style: Theme.of(context).textTheme.overline,
        ),
        Padding(
          padding: const EdgeInsets.only(left: PaddingValues.medium),
          child: Icon(
            Icons.circle,
            color: isOpen ? AppColor.open : AppColor.closed,
            size: 8.0,
          ),
        ),
      ],
    );
  }
}
