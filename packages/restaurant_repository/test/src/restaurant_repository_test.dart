// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

void main() {
  group('RestaurantRepository', () {
    test('can be instantiated', () {
      expect(RestaurantRepository(), isNotNull);
    });
  });
}
