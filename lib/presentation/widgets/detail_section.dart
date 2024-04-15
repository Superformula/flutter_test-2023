import 'package:flutter/material.dart';

class DetailSection extends StatelessWidget {
  final String title;
  final Widget child;

  const DetailSection({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 16),
        child,
        const SizedBox(height: 12),
      ],
    );
  }
}
