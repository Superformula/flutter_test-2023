import 'package:flutter/material.dart';

class OpenClosed extends StatelessWidget {
  const OpenClosed({Key? key, required this.open}) : super(key: key);

  final bool open;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          open ? 'Open Now' : 'Closed',
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 4),
        DecoratedBox(
          decoration: BoxDecoration(
            color: open ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
          child: const SizedBox.square(
            dimension: 7,
          ),
        ),
      ],
    );
  }
}
