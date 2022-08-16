import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:superformula_flutter_test/blocs/restaurant_list/restaurant_list_bloc.dart';
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

    test('emits states in the order [RestaurantListInitial, RestaurantListLoading, RestaurantListLoaded]', () {
      when(() => mockNetworkProvider.fetchRestaurants()).thenAnswer((_) async => mockRestaurantResult);

      final RestaurantListBloc restaurantListBloc = RestaurantListBloc(mockNetworkProvider);

      expect(restaurantListBloc.state, isA<RestaurantListInitial>());

      restaurantListBloc.add(FetchRestaurants(0));

      expectLater(
        restaurantListBloc.stream,
        emitsInOrder(
          [
            isA<RestaurantListLoading>(),
            isA<RestaurantListLoaded>(),
          ],
        ),
      );
    });

    test('emits failed state when fetchRestaurants fails', () {
      when(() => mockNetworkProvider.fetchRestaurants()).thenThrow(Exception());

      final RestaurantListBloc restaurantListBloc = RestaurantListBloc(mockNetworkProvider);

      expect(restaurantListBloc.state, isA<RestaurantListInitial>());

      restaurantListBloc.add(FetchRestaurants(0));

      expectLater(
        restaurantListBloc.stream,
        emitsInOrder(
          [
            isA<RestaurantListLoading>(),
            isA<RestaurantListError>(),
          ],
        ),
      );
    });
  });
}
