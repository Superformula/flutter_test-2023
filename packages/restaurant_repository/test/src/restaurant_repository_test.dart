// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:yelp_api/yelp_api.dart' as yelp_api;

class MockYelpApi extends Mock implements yelp_api.YelpApi {}

void main() {
  group('RestaurantRepository', () {
    late yelp_api.YelpApi yelpApi;
    late RestaurantRepository restaurantRepository;

    setUp(() {
      yelpApi = MockYelpApi();
      restaurantRepository = RestaurantRepository(yelpApi: yelpApi);
    });

    group('getRestaurants', () {
      test('calls getRestaurants with correct offset', () async {
        try {
          await restaurantRepository.getRestaurants();
        } catch (_) {}
        verify(() => yelpApi.getRestaurants(offset: 0)).called(1);
      });

      test('throws when getRestaurants fails', () async {
        final exception = Exception();
        when(() => yelpApi.getRestaurants()).thenThrow(exception);

        expect(
          () async => await restaurantRepository.getRestaurants(),
          throwsA(exception),
        );
      });

      test('updates allRestaurants on success', () async {
        when(() => yelpApi.getRestaurants()).thenAnswer(
          (_) async => yelp_api.RestaurantQueryResult(
            restaurants: [
              yelp_api.Restaurant(id: '1'),
              yelp_api.Restaurant(id: '2'),
            ],
          ),
        );

        await restaurantRepository.getRestaurants();
        expect(
          restaurantRepository.allRestaurants,
          [
            Restaurant(id: '1', isOpenNow: false),
            Restaurant(id: '2', isOpenNow: false),
          ],
        );
      });
    });
    group('getRestaurant', () {
      test('calls getRestaurant with correct restaurantId', () async {
        try {
          await restaurantRepository.getRestaurant('restaurantId');
        } catch (_) {}
        verify(() => yelpApi.getRestaurant('restaurantId')).called(1);
      });

      test('throws when getRestaurants fails', () async {
        final exception = Exception();
        when(() => yelpApi.getRestaurant('restaurantId')).thenThrow(exception);

        expect(
          () async => await restaurantRepository.getRestaurant('restaurantId'),
          throwsA(exception),
        );
      });
    });
  });
}
