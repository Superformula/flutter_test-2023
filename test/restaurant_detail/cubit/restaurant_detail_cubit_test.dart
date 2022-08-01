import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/restaurant_detail/cubit/restaurant_detail_cubit.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late RestaurantRepository restaurantRepository;
  late UserRepository userRepository;
  group('RestaurantDetailCubit', () {
    setUp(() {
      restaurantRepository = MockRestaurantRepository();
      userRepository = MockUserRepository();
      when(() => userRepository.favoriteRestaurants)
          .thenAnswer((_) => const Stream.empty());
      when(() => restaurantRepository.restaurants)
          .thenAnswer((_) => const Stream.empty());
      when(() => restaurantRepository.getRestaurants())
          .thenAnswer((_) async {});
    });
    RestaurantDetailCubit buildCubit() => RestaurantDetailCubit(
          restaurantId: '',
          restaurantRepository: restaurantRepository,
          userRepository: userRepository,
        );

    group('constructor', () {
      test('works properly', () {
        expect(buildCubit, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildCubit().state,
          equals(const RestaurantDetailState(restaurantId: '')),
        );
      });
    });
    group('init', () {
      blocTest<RestaurantDetailCubit, RestaurantDetailState>(
        'emits [restaurant] when restaurantRepository fetch the restaurant',
        setUp: () {
          when(() => restaurantRepository.getRestaurant('restaurantId'))
              .thenAnswer(
            (_) async => const Restaurant(name: 'restaurant_test'),
          );
          when(() => userRepository.isFavorite('restaurantId'))
              .thenAnswer((_) => true);
        },
        build: buildCubit,
        seed: () => const RestaurantDetailState(
          restaurantId: 'restaurantId',
          status: RestaurantDetailStatus.initial,
        ),
        act: (homeCubit) => homeCubit.init(),
        expect: () => <RestaurantDetailState>[
          const RestaurantDetailState(
            restaurantId: 'restaurantId',
            restaurant: Restaurant(name: 'restaurant_test'),
            isFavorite: true,
            status: RestaurantDetailStatus.loaded,
          ),
        ],
      );
    });

    group('toggleFavorite', () {
      blocTest<RestaurantDetailCubit, RestaurantDetailState>(
        'emits [true] when toggleFavorite is called and isFavorite is false',
        setUp: () {
          when(() => userRepository.favoriteRestaurants).thenAnswer(
            (_) => Stream.value([const Restaurant(name: 'restaurant_test')]),
          );
          when(
            () => userRepository.addFavoriteRestaurant(
              const Restaurant(name: 'restaurant_test'),
            ),
          ).thenAnswer((_) {});
        },
        build: buildCubit,
        seed: () => const RestaurantDetailState(
          restaurantId: 'restaurantId',
          restaurant: Restaurant(name: 'restaurant_test'),
          status: RestaurantDetailStatus.loaded,
          isFavorite: false,
        ),
        act: (homeCubit) => homeCubit.toggleFavorite(),
        expect: () => <RestaurantDetailState>[
          const RestaurantDetailState(
            restaurantId: 'restaurantId',
            restaurant: Restaurant(name: 'restaurant_test'),
            status: RestaurantDetailStatus.loaded,
            isFavorite: true,
          ),
        ],
      );
    });
  });
}
