import 'package:flutter/material.dart';

class AvailabilityIndicator extends StatelessWidget {
  final bool isOpen;
  final String isOpenText;
  final String isClosedText;

  const AvailabilityIndicator({
    super.key,
    required this.isOpen,
    required this.isOpenText,
    required this.isClosedText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          isOpen ? isOpenText : isClosedText,
          style: theme.textTheme.overline,
        ),
        const SizedBox(width: 8.0),
        Icon(
          Icons.circle,
          color: isOpen ? const Color(0xff5CD313) : const Color(0xffEA5E5E),
          size: 8.0,
        ),
      ],
    );
  }
}
