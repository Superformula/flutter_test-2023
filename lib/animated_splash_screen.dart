import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatelessWidget {
  const AnimatedSplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.asset(
            "assets/gifs/cutlery.gif",
            height: 125.0,
            width: 125.0,
          ),
        ),
      ),
    );
  }
}
