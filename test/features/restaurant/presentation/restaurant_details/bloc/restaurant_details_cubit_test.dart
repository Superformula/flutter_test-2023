import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/add_favorite_restaurant_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/delete_favorite_restaurant_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_favorites_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_state.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_cubit.dart';

import '../../../restaurant_mockup.dart';

class MockGetFavoriteRestaurantsUseCase extends Mock
    implements GetFavoriteRestaurantsUseCase {}

class MockDeleteFavoriteRestaurantUseCase extends Mock
    implements DeleteFavoriteRestaurantUseCase {}

class MockInsertFavoriteRestaurantUseCase extends Mock
    implements InsertFavoriteRestaurantUseCase {}

void main() {
  late RestaurantDetailCubit cubit;
  late MockGetFavoriteRestaurantsUseCase mockGetFavoriteRestaurantsUseCase;
  late MockDeleteFavoriteRestaurantUseCase mockDeleteFavoriteRestaurantUseCase;
  late MockInsertFavoriteRestaurantUseCase mockInsertFavoriteRestaurantUseCase;

  setUp(() {
    mockGetFavoriteRestaurantsUseCase = MockGetFavoriteRestaurantsUseCase();
    mockDeleteFavoriteRestaurantUseCase = MockDeleteFavoriteRestaurantUseCase();
    mockInsertFavoriteRestaurantUseCase = MockInsertFavoriteRestaurantUseCase();
    GetIt.I.registerSingleton<GetFavoriteRestaurantsUseCase>(
      mockGetFavoriteRestaurantsUseCase,
    );
    GetIt.I.registerSingleton<DeleteFavoriteRestaurantUseCase>(
      mockDeleteFavoriteRestaurantUseCase,
    );
    GetIt.I.registerSingleton<InsertFavoriteRestaurantUseCase>(
      mockInsertFavoriteRestaurantUseCase,
    );
    cubit = RestaurantDetailCubit();
  });

  tearDown(() {
    GetIt.I.unregister<GetFavoriteRestaurantsUseCase>();
    GetIt.I.unregister<DeleteFavoriteRestaurantUseCase>();
    GetIt.I.unregister<InsertFavoriteRestaurantUseCase>();
  });

  blocTest<RestaurantDetailCubit, RestaurantDetailState>(
    'emits [RestaurantDetailLoading, RestaurantDetailLoaded] when fetchRestaurantDetail is called',
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetFavoriteRestaurantsUseCase.call())
          .thenAnswer((_) async => [restaurantMockup]);
      cubit.fetchRestaurantDetail(
        restaurantMockup,
      );
    },
    expect: () => <RestaurantDetailState>[
      RestaurantDetailLoaded(
        isFavorited: true,
        restaurant: restaurantMockup,
      ),
    ],
  );

  blocTest<RestaurantDetailCubit, RestaurantDetailState>(
    'emits [RestaurantDetailLoading, RestaurantDetailLoaded] when fetchRestaurantDetail is called'
    'and restaurant is not favorited',
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetFavoriteRestaurantsUseCase.call())
          .thenAnswer((_) async => []);
      cubit.fetchRestaurantDetail(
        restaurantMockup,
      );
    },
    expect: () => <RestaurantDetailState>[
      RestaurantDetailLoaded(
        isFavorited: false,
        restaurant: restaurantMockup,
      ),
    ],
  );
}
