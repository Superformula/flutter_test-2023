import 'package:flutter/material.dart';

class OpenStatusIndicator extends StatelessWidget {
  const OpenStatusIndicator({
    Key? key,
    required this.isOpen,
  }) : super(key: key);
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(isOpen ? 'Open' : 'Closed'),
        const SizedBox(width: 4),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOpen ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
