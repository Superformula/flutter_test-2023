import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:superformula_flutter_test/blocs/restaurants/restaurants_bloc.dart';
import 'package:superformula_flutter_test/models/restaurant.dart';

import 'utils/mock_network_provider.dart';

void main() {
  late MockNetworkProvider mockNetworkProvider;

  setUp(() {
    mockNetworkProvider = MockNetworkProvider();
  });

  group('RestaurantBloc', () {
    final List<Restaurant> mockRestaurants = [
      Restaurant(),
      Restaurant(),
      Restaurant(),
    ];

    final RestaurantResult mockRestaurantResult = RestaurantResult(total: 3, restaurants: mockRestaurants);

    test('emits states in the order [RestaurantsInitial, RestaurantsLoading, RestaurantsLoaded]', () {
      when(() => mockNetworkProvider.fetchRestaurants()).thenAnswer((_) async => mockRestaurantResult);

      final RestaurantsBloc restaurantsBloc = RestaurantsBloc(mockNetworkProvider);

      expect(restaurantsBloc.state, isA<RestaurantsInitial>());

      restaurantsBloc.add(FetchRestaurants(0));

      expectLater(
        restaurantsBloc.stream,
        emitsInOrder(
          [
            isA<RestaurantsLoading>(),
            isA<RestaurantsLoaded>(),
          ],
        ),
      );
    });

    test('emits failed state when fetchRestaurants fails', () {
      when(() => mockNetworkProvider.fetchRestaurants()).thenThrow(Exception());

      final RestaurantsBloc restaurantsBloc = RestaurantsBloc(mockNetworkProvider);

      expect(restaurantsBloc.state, isA<RestaurantsInitial>());

      restaurantsBloc.add(FetchRestaurants(0));

      expectLater(
        restaurantsBloc.stream,
        emitsInOrder(
          [
            isA<RestaurantsLoading>(),
            isA<RestaurantsError>(),
          ],
        ),
      );
    });
  });
}
