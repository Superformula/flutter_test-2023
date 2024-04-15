import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/widgets/opennow_widget.dart';

void main() {
  testWidgets("Open now widget should always return a text",
      (widgetTester) async {
    await widgetTester.pumpWidget(OpenNowWidget(isOpen: true));

    final textFinder = find.text('open');

    expect(textFinder, findsWidgets);
  });
}
