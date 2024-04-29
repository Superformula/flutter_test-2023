import 'package:flutter/material.dart';

class AvailabilityIndicator extends StatelessWidget {
  final bool isOpen;
  const AvailabilityIndicator({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(isOpen ? 'Open Now' : 'Closed'),
          const SizedBox(width: 8.0),
          Icon(
            Icons.circle,
            color: isOpen ? const Color(0xff5CD313) : const Color(0xffEA5E5E),
            size: 8.0,
          ),
        ],
      );
}
