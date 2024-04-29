import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurantour/navigation.dart';

void main() {
  group('GoRouter', () {
    test('Router test', () {
      expect(router, isA<GoRouter>());
      final routes = router.configuration.routes;

      expect(routes.length, equals(1));
      expect((routes.first).routes.length, equals(1));
    });

    test('Route names', () {
      expect(listPage, equals('/'));
      expect(detailPage, equals('/detail'));
    });
  });
}
