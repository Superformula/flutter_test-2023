import 'package:flutter/material.dart';

class StatusRow extends StatelessWidget {
  final bool isOpenNow;

  const StatusRow({Key? key, required this.isOpenNow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isOpenNow ? const Color(0xFF5CD313) : const Color(0xFFEA5E5E);
    final text = isOpenNow ? 'Open Now' : 'Closed';

    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.circle, color: color, size: 16),
      ],
    );
  }
}
