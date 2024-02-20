import 'package:flutter/material.dart';

class myDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 0.5,
        color: const Color.fromARGB(255, 213, 213, 213),
      ),
    );
  }
}
