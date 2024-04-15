import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  final String address;

  const AddressWidget({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text('Address', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 24),
        Text(address, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 12),
      ],
    );
  }
}
