import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelp_api/yelp_api.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('YelpApi', () {
    late Dio dioClient;
    setUp(() {
      dioClient = MockDio();
    });
    test('can be instantiated', () {
      expect(GraphQlYelpApiClient(dio: dioClient), isNotNull);
    });
  });
}
