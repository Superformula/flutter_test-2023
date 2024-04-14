import 'package:flutter/material.dart';

class ColumnLoadingPlaceholder extends StatelessWidget {
  const ColumnLoadingPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          semanticsLabel: 'Loading',
          color: Colors.black,
        ),
      ],
    );
  }
}
