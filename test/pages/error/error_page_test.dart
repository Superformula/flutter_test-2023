import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/localization/localization.dart';
import 'package:restaurantour/pages/error/error_page.dart';

import '../../test_utils/helper_functions.dart';
import '../../test_utils/mock_wrapper.dart';

void main() {
  group('ErrorPage', () {
    late AppLocalizations l10n;

    setUpAll(() async {
      l10n = await loadEnglishLocalizations();
    });

    testWidgets('Smoke', (tester) async {
      await tester.pumpWidget(
        const MockWrapper(
          child: ErrorPage(),
        ),
      );

      expect(find.byType(ErrorPage), findsOneWidget);
      expect(find.text(l10n.error), findsOneWidget);
    });

    testWidgets('Golden test', (tester) async {
      await tester.pumpWidget(
        const MockWrapper(
          child: ErrorPage(),
        ),
      );

      await expectLater(
        find.byType(MockWrapper),
        matchesGoldenFile('goldens/error_page.png'),
      );
    });
  });
}
