import 'package:flutter/material.dart';
import 'package:restaurantour/theme/style.dart';

class OpenNowWidget extends StatelessWidget {
  final bool isOpen;
  const OpenNowWidget(this.isOpen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isOpen) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Open Now',
            style: overlineStyle,
          ),
          const SizedBox(width: 5.0),
          Container(
            height: 10.0,
            width: 10.0,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: openColor),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Closed',
            style: overlineStyle,
          ),
          const SizedBox(width: 5.0),
          Container(
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: closeColor),
          ),
        ],
      );
    }
  }
}
