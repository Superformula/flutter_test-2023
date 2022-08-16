import 'package:flutter/material.dart';

enum RestaurantStatus { open, closed }

class RestaurantStatusWidget extends StatelessWidget {
  final RestaurantStatus status;
  const RestaurantStatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Open Now", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
        SizedBox(width: 4),
        Icon(Icons.fiber_manual_record, size: 12, color: Colors.green[400]),
      ],
    );
  }
}
