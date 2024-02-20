import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  final String address;

  const AddressWidget({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Address',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          address,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
