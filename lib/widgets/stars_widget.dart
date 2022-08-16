import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  final int starCount;
  const StarsWidget({Key? key, required this.starCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) => Icon(Icons.star, size: 20, color: Colors.yellow[700]),
      ),
    );
  }
}
