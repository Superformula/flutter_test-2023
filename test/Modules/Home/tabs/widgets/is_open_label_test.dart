import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/is_open_label.dart';

void main() {
  testWidgets(
      'IsOpenLabel should display correct text and color based on isOpen value',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: IsOpenLabel(isOpen: true),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the widget displays "Open Now" text
    expect(find.text('Open Now'), findsOneWidget);

    // Verify if the widget displays a green circle indicating open status
    var greenColor = Colors.green.value;
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color!.value == greenColor,
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: IsOpenLabel(isOpen: false),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the widget displays "Closed" text
    expect(find.text('Closed'), findsOneWidget);

    // Verify if the widget displays a red circle indicating closed status
    var redColor = Colors.red.value;
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color!.value == redColor,
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: IsOpenLabel(isOpen: null),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the widget displays "not informed" text
    expect(find.text('not informed'), findsOneWidget);
  });
}
