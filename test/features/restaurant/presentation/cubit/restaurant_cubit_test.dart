import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/features/restaurant/domain/entities/location_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/review_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/user_entity.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_all_restaurants_usecases.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/get_favorite_restaurants_ids_usecase.dart';
import 'package:restaurantour/features/restaurant/domain/usecases/set_favorite_restaurants_ids_usecase.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/restaurants_cubit.dart';

class _MockGetAllRestaurantsUseCase extends Mock
    implements GetAllRestaurantsUseCase {}

class _MockGetFavoriteRestaurantsIdsUseCase extends Mock
    implements GetFavoriteRestaurantsIdsUseCase {}

class _MockSetFavoriteRestaurantsIdsUseCase extends Mock
    implements SetFavoriteRestaurantsIdsUseCase {}

void main() {
  late _MockGetAllRestaurantsUseCase _mockGetAllRestaurantsUseCase;
  late _MockGetFavoriteRestaurantsIdsUseCase
      _mockGetFavoriteRestaurantsIdsUseCase;
  late _MockSetFavoriteRestaurantsIdsUseCase
      _mockSetFavoriteRestaurantsIdsUseCase;

  late RestaurantsCubit cubit;

  late RestaurantEntity tRestaurant;

  setUp(() {
    _mockGetAllRestaurantsUseCase = _MockGetAllRestaurantsUseCase();
    _mockGetFavoriteRestaurantsIdsUseCase =
        _MockGetFavoriteRestaurantsIdsUseCase();
    _mockSetFavoriteRestaurantsIdsUseCase =
        _MockSetFavoriteRestaurantsIdsUseCase();

    cubit = RestaurantsCubit(
      getAllRestaurantsUseCase: _mockGetAllRestaurantsUseCase,
      getFavoriteRestaurantsIdsUseCase: _mockGetFavoriteRestaurantsIdsUseCase,
      setFavoriteRestaurantsIdsUseCase: _mockSetFavoriteRestaurantsIdsUseCase,
    );

    tRestaurant = const RestaurantEntity(
      id: "id",
      name: "Yardbird Southern Table & Bar",
      price: "\$\$\$",
      photos: [],
      location: LocationEntity(formattedAddress: "Baker Street"),
      rating: 4.5,
      reviews: [
        ReviewEntity(
          rating: 5,
          user: UserEntity(
            name: "Crystal L.",
            imageUrl: "",
          ),
        ),
      ],
    );
  });

  group(
    'RestaurantsCubit tests',
    () {
      test('Verifies initial state', () {
        expect(cubit.state, RestaurantsInitial());
      });

      blocTest<RestaurantsCubit, RestaurantsState>(
        'All and Favorite Restaurants loaded successfully',
        build: () {
          when(
            () => _mockGetAllRestaurantsUseCase(),
          ).thenAnswer(
            (_) async => Right([tRestaurant]),
          );
          when(
            () => _mockGetFavoriteRestaurantsIdsUseCase(),
          ).thenAnswer(
            (_) async => [tRestaurant.id!],
          );

          return cubit;
        },
        act: (cubit) async => await cubit.loadRestaurantsList(),
        expect: () => [
          RestaurantsLoading(),
          RestaurantsLoaded(
            restaurants: [tRestaurant],
            favoriteRestaurants: [tRestaurant],
          ),
        ],
      );

      blocTest<RestaurantsCubit, RestaurantsState>(
        'Adds new favorite restaurant',
        build: () {
          final List<RestaurantEntity> tRestaurantList = [tRestaurant];
          final List<String> tFavoriteList = [];

          when(
            () => _mockGetAllRestaurantsUseCase(),
          ).thenAnswer(
            (_) async => Right(tRestaurantList),
          );
          when(
            () => _mockGetFavoriteRestaurantsIdsUseCase(),
          ).thenAnswer(
            (_) async => tFavoriteList,
          );
          when(
            () => _mockSetFavoriteRestaurantsIdsUseCase(
              favoriteRestaurantIdsList: any(
                named: 'favoriteRestaurantIdsList',
              ),
            ),
          ).thenAnswer(
            (_) async => tFavoriteList..add(tRestaurant.id!),
          );

          return cubit;
        },
        act: (cubit) async {
          await cubit.loadRestaurantsList();
          await cubit.addFavoriteRestaurantId(id: tRestaurant.id);
        },
        expect: () => [
          RestaurantsLoading(),
          RestaurantsLoaded(
            restaurants: [tRestaurant],
            favoriteRestaurants: const [],
          ),
          RestaurantsLoaded(
            restaurants: [tRestaurant],
            favoriteRestaurants: [tRestaurant],
          ),
        ],
      );

      blocTest<RestaurantsCubit, RestaurantsState>(
        'Adds new favorite restaurant',
        build: () {
          final List<RestaurantEntity> tRestaurantList = [tRestaurant];
          final List<String> tFavoriteList = [tRestaurant.id!];

          when(
            () => _mockGetAllRestaurantsUseCase(),
          ).thenAnswer(
            (_) async => Right(tRestaurantList),
          );
          when(
            () => _mockGetFavoriteRestaurantsIdsUseCase(),
          ).thenAnswer(
            (_) async => tFavoriteList,
          );
          when(
            () => _mockSetFavoriteRestaurantsIdsUseCase(
              favoriteRestaurantIdsList: any(
                named: 'favoriteRestaurantIdsList',
              ),
            ),
          ).thenAnswer(
            (_) async => tFavoriteList..remove(tRestaurant.id!),
          );

          return cubit;
        },
        act: (cubit) async {
          await cubit.loadRestaurantsList();
          await cubit.deleteFavoriteRestaurantId(id: tRestaurant.id);
        },
        expect: () => [
          RestaurantsLoading(),
          RestaurantsLoaded(
            restaurants: [tRestaurant],
            favoriteRestaurants: [tRestaurant],
          ),
          RestaurantsLoaded(
            restaurants: [tRestaurant],
            favoriteRestaurants: const [],
          ),
        ],
      );
    },
  );
}
