import 'package:flutter_test/flutter_test.dart';

import 'package:restaurantour/main.dart';

void main() {
  testWidgets('Page loads', (WidgetTester tester) async {
    await tester.pumpWidget(const RestauranTour());

    expect(find.text('Fetch Restaurants'), findsOneWidget);
  });
}
