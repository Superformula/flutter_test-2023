import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('navigate between tabs', (tester) async {
      await setupInjection();
      await tester.pumpWidget(const App());

      // Verify if the app loads
      expect(find.byKey(const Key('all-restaurants-tab')), findsOneWidget);
      expect(find.byKey(const Key('my-favorites-tab')), findsOneWidget);

      // Navigate between tabs
      await tester.tap(find.byKey(const Key('my-favorites-tab')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('all-restaurants-tab')));
      await tester.pumpAndSettle();
    });
  });
}
