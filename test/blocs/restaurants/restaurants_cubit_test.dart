import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/blocs/restaurants/restaurants_cubit.dart';
import 'package:restaurantour/core/constants/constants.dart';
import 'package:restaurantour/data/data.dart';
import 'package:restaurantour/ui/models/restaurant_ui.dart';

import '../../mocks/repositories/mock_yelp_repository.dart';

void main() {
  late MockYelpRepository mockRepository;
  late RestaurantsCubit restaurantsCubit;

  setUpAll(() {
    mockRepository = MockYelpRepository();
  });

  setUp(() {
    restaurantsCubit = RestaurantsCubit(mockRepository);
  });

  group('getRestaurants()', () {
    void act(RestaurantsCubit cubit) => cubit.getRestaurants();

    Future<Either<RestaurantFailure, RestaurantQueryResult>>
        callingGetRestaurants() {
      return mockRepository.getRestaurants(
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      );
    }

    List<Restaurant> mockRestaurants() => List.generate(
          Constants.restaurantsToFetch,
          (index) => Restaurant(id: index.toString()),
        );

    blocTest<RestaurantsCubit, RestaurantsState>(
      'when it gets an empty list of restaurants',
      build: () {
        when(callingGetRestaurants).thenAnswer((_) async {
          const response = RestaurantQueryResult(total: 0, restaurants: []);

          return const Right(response);
        });

        return restaurantsCubit;
      },
      act: act,
      expect: () => [
        RestaurantsState.initial(),
        RestaurantsState.initial()
            .copyWith(isLoading: false, hasMore: false, restaurants: []),
      ],
      verify: (_) {
        verify(callingGetRestaurants).called(1);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
      'when it gets a list of restaurants',
      build: () {
        when(callingGetRestaurants).thenAnswer((_) async {
          final response = RestaurantQueryResult(
            total: 100,
            restaurants: mockRestaurants(),
          );

          return Right(response);
        });

        return restaurantsCubit;
      },
      act: act,
      expect: () => [
        RestaurantsState.initial(),
        RestaurantsState.initial().copyWith(
          isLoading: false,
          hasMore: true,
          offset: 20,
          restaurants: mockRestaurants()
              .map((r) => RestaurantUi(restaurant: r))
              .toList(),
        ),
      ],
      verify: (_) {
        verify(callingGetRestaurants).called(1);
      },
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
      'when it gets a failure',
      build: () {
        when(callingGetRestaurants).thenAnswer((_) async {
          return left(const RestaurantFailure.unauthorized());
        });

        return restaurantsCubit;
      },
      act: act,
      expect: () => [
        RestaurantsState.initial(),
        RestaurantsState.initial().copyWith(
          isLoading: false,
          failure: optionOf(const RestaurantFailure.unauthorized()),
        ),
      ],
      verify: (_) {
        verify(callingGetRestaurants).called(1);
      },
    );
  });

  group('favoriteToggled()', () {
    blocTest<RestaurantsCubit, RestaurantsState>(
      'from false to true',
      build: () => restaurantsCubit,
      act: (cubit) => cubit.favoriteToggled(restaurantId: '2'),
      seed: () => RestaurantsState.initial().copyWith(
        restaurants: const [
          RestaurantUi(restaurant: Restaurant(id: '1')),
          RestaurantUi(restaurant: Restaurant(id: '2')),
        ],
      ),
      expect: () => [
        RestaurantsState.initial().copyWith(
          restaurants: const [
            RestaurantUi(restaurant: Restaurant(id: '1')),
            RestaurantUi(restaurant: Restaurant(id: '2'), isFavorite: true),
          ],
        ),
      ],
    );

    blocTest<RestaurantsCubit, RestaurantsState>(
      'from true to false',
      build: () => restaurantsCubit,
      act: (cubit) => cubit.favoriteToggled(restaurantId: '2'),
      seed: () => RestaurantsState.initial().copyWith(
        restaurants: const [
          RestaurantUi(restaurant: Restaurant(id: '1')),
          RestaurantUi(restaurant: Restaurant(id: '2'), isFavorite: true),
        ],
      ),
      expect: () => [
        RestaurantsState.initial().copyWith(
          restaurants: const [
            RestaurantUi(restaurant: Restaurant(id: '1')),
            RestaurantUi(restaurant: Restaurant(id: '2'), isFavorite: false),
          ],
        ),
      ],
    );
  });
}
