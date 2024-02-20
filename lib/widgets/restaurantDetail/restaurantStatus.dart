import 'package:flutter/material.dart';

class RestaurantStatus extends StatelessWidget {
  final bool isOpen;

  const RestaurantStatus({Key? key, required this.isOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          isOpen ? 'Open Now' : 'Closed',
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOpen ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
