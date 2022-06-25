import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class IsOpen extends StatelessWidget {
  final ThemeData theme;
  final bool isOpen;

  const IsOpen(this.theme, this.isOpen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isOpen ? "Open Now" : "Closed",
          style: theme.textTheme.overline!.copyWith(letterSpacing: -0.5),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
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
