import 'package:flutter/material.dart';

void main() {
  runApp(JobBoardApp());
}

class JobBoardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      home: Scaffold(
        body: Center(
          child: Text(
            'Job Board',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
