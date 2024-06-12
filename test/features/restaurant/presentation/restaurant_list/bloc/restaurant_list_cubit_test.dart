import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_favorites_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/bloc/restaurant_list_cubit.dart';

import '../../../restaurant_mockup.dart';

class MockGetRestaurantsUseCase extends Mock implements GetRestaurantsUseCase {}

class MockGetFavoriteRestaurantsUseCase extends Mock
    implements GetFavoriteRestaurantsUseCase {}

void main() {
  late RestaurantListCubit cubit;
  late MockGetRestaurantsUseCase mockGetRestaurantsUseCase;
  late MockGetFavoriteRestaurantsUseCase mockGetFavoriteRestaurantsUseCase;

  setUp(() {
    mockGetRestaurantsUseCase = MockGetRestaurantsUseCase();
    mockGetFavoriteRestaurantsUseCase = MockGetFavoriteRestaurantsUseCase();
    GetIt.I.registerSingleton<GetRestaurantsUseCase>(mockGetRestaurantsUseCase);
    GetIt.I.registerSingleton<GetFavoriteRestaurantsUseCase>(
      mockGetFavoriteRestaurantsUseCase,
    );
    cubit = RestaurantListCubit();

    when(() => mockGetFavoriteRestaurantsUseCase.call())
        .thenAnswer((_) async => [restaurantMockup]);
  });

  tearDown(() {
    GetIt.I.unregister<GetRestaurantsUseCase>();
    GetIt.I.unregister<GetFavoriteRestaurantsUseCase>();
  });

  blocTest<RestaurantListCubit, RestaurantListState>(
    'emits [RestaurantListLoading, RestaurantListLoaded] when fetchRestaurants succeeds',
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetRestaurantsUseCase.call(any()))
          .thenAnswer((_) async => [restaurantMockup]);
      cubit.fetchRestaurants();
    },
    expect: () => <RestaurantListState>[
      RestaurantListLoading(),
      RestaurantListLoaded([restaurantMockup]),
    ],
  );

  blocTest<RestaurantListCubit, RestaurantListState>(
    'emits [RestaurantListLoading, RestaurantListLoaded] with a empty list',
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetRestaurantsUseCase.call(any()))
          .thenAnswer((_) async => []);
      cubit.fetchRestaurants();
    },
    expect: () => <RestaurantListState>[
      RestaurantListLoading(),
      const RestaurantListLoaded([]),
    ],
  );

  blocTest<RestaurantListCubit, RestaurantListState>(
    'emits [RestaurantListLoading, RestaurantListError] when a error happens',
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetRestaurantsUseCase.call(any()))
          .thenThrow(Exception('A non-null String must be provided'));
      cubit.fetchRestaurants();
    },
    expect: () => <RestaurantListState>[
      RestaurantListLoading(),
      const RestaurantListError(
        'Exception: A non-null String must be provided',
      ),
    ],
  );

  blocTest<RestaurantListCubit, RestaurantListState>(
    'emits [RestaurantListLoading, FavoriteRestaurantsLoaded] when fetchFavoriteRestaurants succeeds',
    build: () => cubit,
    act: (cubit) => cubit.fetchFavoriteRestaurants(),
    expect: () => <RestaurantListState>[
      RestaurantListLoading(),
      FavoriteRestaurantsLoaded(
        [restaurantMockup],
      ),
    ],
  );
}
