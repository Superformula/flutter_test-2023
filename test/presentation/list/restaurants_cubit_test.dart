import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/restaurant_repository.dart';
import 'package:restaurantour/presentation/list/restaurants_cubit.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  late MockRestaurantRepository repository;
  late RestaurantsCubit cubit;
  const restaurants = [Restaurant()];

  setUp(() {
    repository = MockRestaurantRepository();
    cubit = RestaurantsCubit(repository);
  });

  blocTest<RestaurantsCubit, RestaurantsState>(
    'Failed to fetch restaurants',
    build: () => cubit,
    act: (cubit) {
      when(() => repository.fetchRestaurants()).thenThrow(Exception());
      cubit.fetchRestaurants();
    },
    verify: (_) {
      verify(() => repository.fetchRestaurants()).called(2);
    },
    expect: () => [
      isA<FetchingList>(),
      isA<FailedToFetchRestaurants>(),
    ],
  );

  blocTest<RestaurantsCubit, RestaurantsState>(
    'No restaurants found',
    build: () => cubit,
    act: (cubit) {
      when(() => repository.fetchRestaurants()).thenAnswer((_) async => []);
      cubit.fetchRestaurants();
    },
    verify: (_) {
      verify(() => repository.fetchRestaurants()).called(2);
    },
    expect: () => [
      isA<FetchingList>(),
      isA<NoRestaurantsFound>(),
    ],
  );

  blocTest<RestaurantsCubit, RestaurantsState>(
    'Successfully fetched restaurants',
    build: () => cubit,
    act: (cubit) {
      when(() => repository.fetchRestaurants())
          .thenAnswer((_) async => restaurants);
      cubit.fetchRestaurants();
    },
    verify: (_) {
      verify(() => repository.fetchRestaurants()).called(2);
    },
    expect: () => [
      isA<FetchingList>(),
      isA<RestaurantsList>().having(
        (state) => state.restaurants,
        'restaurants',
        equals(restaurants),
      ),
    ],
  );
}
