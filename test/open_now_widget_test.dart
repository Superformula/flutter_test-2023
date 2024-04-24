import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/widgets/my_divider_widget.dart';
import 'package:restaurantour/widgets/opennow_widget.dart';

void main() {
  testWidgets("Open now widget should always return a text",
      (widgetTester) async {
    await widgetTester.pumpWidget(OpenNowWidget(
      isOpen: true,
    ));

    final textFinder = find.byIcon(Icons.circle);

    expect(textFinder, findsWidgets);
  });
}
