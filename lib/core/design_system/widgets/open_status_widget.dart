import 'package:flutter/material.dart';

class OpenStatus extends StatelessWidget {
  const OpenStatus({Key? key, required this.isOpen}) : super(key: key);

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isOpen ? 'Open Now' : 'Closed',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.circle,
          color: isOpen ? Colors.green : Colors.red,
          size: 12,
        ),
      ],
    );
  }
}
