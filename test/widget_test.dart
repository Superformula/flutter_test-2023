import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/presentation/widgets/address_widget.dart';

void main() {
  testWidgets(
    'AddressWidget displays correct title and address',
    (WidgetTester tester) async {
      // Build the AddressWidget with a specific address.
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AddressWidget(
              address: '123 Main St',
            ),
          ),
        ),
      );

      // Verify that the AddressWidget contains the correct title and address.
      expect(
        find.text('Address'),
        findsOneWidget,
        reason: 'Title is not found',
      );
      expect(
        find.text('123 Main St'),
        findsOneWidget,
        reason: 'Address is not found',
      );
    },
  );
}
