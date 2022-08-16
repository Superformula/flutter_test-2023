import 'package:flutter/material.dart';

class RestaurantStatusWidget extends StatelessWidget {
  final RestaurantStatus status;
  const RestaurantStatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(status.toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
        SizedBox(width: 4),
        Icon(Icons.fiber_manual_record, size: 12, color: status == RestaurantStatus.open ? Colors.green[400] : Colors.red[300]),
      ],
    );
  }
}

enum RestaurantStatus {
  open,
  closed;

  @override
  String toString() {
    if (this == RestaurantStatus.open) return "Open Now";
    if (this == RestaurantStatus.closed) return "Closed";
    return "N/A";
  }
}