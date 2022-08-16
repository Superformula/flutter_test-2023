import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class SuperformulaApp extends StatelessWidget {
  const SuperformulaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superformula Test',
      home: const HomeScreen(),
    );
  }
}
