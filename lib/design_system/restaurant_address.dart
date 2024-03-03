import 'package:flutter/material.dart';

class RestaurantAddress extends StatelessWidget {
  const RestaurantAddress({
    Key? key,
    required this.address,
  }) : super(key: key);
  final String address;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            address,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
