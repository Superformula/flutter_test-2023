import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    final child = Scaffold(body: widget);

    return pumpWidget(
      MaterialApp(home: child),
    );
  }
}
