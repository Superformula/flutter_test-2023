import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/widgets/restaurantDetail/addressWidget.dart';

void main() {
  testWidgets('AddressWidget should render correctly',
      (WidgetTester tester) async {
    // Arrange
    const address = '123 Main St, City, Country';
    await tester.pumpWidget(
      const MaterialApp(
        home: AddressWidget(address: address),
      ),
    );

    // Assert
    expect(find.text('Address'), findsOneWidget);
    expect(find.text(address), findsOneWidget);
  });
}
