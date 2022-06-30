import 'package:flutter/material.dart';
import 'package:restaurantour/ui/values/values.dart';

class EmptySection extends StatelessWidget {
  final IconData icon;
  final String title;

  const EmptySection({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 62),
        const SizedBox(height: PaddingValues.l),
        Text(title),
      ],
    );
  }
}
