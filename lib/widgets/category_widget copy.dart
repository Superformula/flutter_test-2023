import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  String text;
  CategoryWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
