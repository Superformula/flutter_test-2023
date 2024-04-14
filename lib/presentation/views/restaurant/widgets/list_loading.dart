import 'package:flutter/material.dart';

class ListLoading extends StatelessWidget {
  const ListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          semanticsLabel: 'Loading restaurants',
          color: Colors.black,
        ),
      ],
    );
  }
}
