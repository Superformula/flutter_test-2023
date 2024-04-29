import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/utils/utils.dart';

void main() {
  group('AppConstants', () {
    test('Smoke test', () {
      expect(AppConstants.baseUrl, equals('https://api.yelp.com/v3/graphql'));
      expect(AppConstants.apiKey, equals(''));
    });
  });
}
