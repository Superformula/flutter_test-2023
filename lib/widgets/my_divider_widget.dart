import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      child: Divider(
        color: Colors.black12,
      ),
    );
  }
}
