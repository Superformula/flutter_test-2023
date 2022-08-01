import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/home/home.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late RestaurantRepository restaurantRepository;
  late UserRepository userRepository;
  group('HomeCubit', () {
    setUp(() {
      restaurantRepository = MockRestaurantRepository();
      userRepository = MockUserRepository();
      when(() => userRepository.favorites)
          .thenAnswer((_) => const Stream.empty());
      when(() => restaurantRepository.restaurants)
          .thenAnswer((_) => const Stream.empty());
      when(() => restaurantRepository.getRestaurants())
          .thenAnswer((_) async {});
    });
    HomeCubit buildCubit() => HomeCubit(
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
          equals(const HomeState()),
        );
      });
    });
    group('loadRestaurants', () {
      blocTest<HomeCubit, HomeState>(
        'emits nothing when AllRestaurantsStatus is completed',
        build: buildCubit,
        seed: () => const HomeState(
          allRestaurantsStatus: HomeListStatus.completed,
        ),
        act: (homeCubit) => homeCubit.loadRestaurants(),
        expect: () => <HomeState>[],
      );

      blocTest<HomeCubit, HomeState>(
        'emits loaded status when restaurantRepository fetches restaurants',
        setUp: () {
          when(() => restaurantRepository.restaurants).thenAnswer(
            (_) =>
                Stream.value(List.generate(10, (index) => const Restaurant())),
          );
        },
        build: buildCubit,
        seed: () => const HomeState(
          allRestaurantsStatus: HomeListStatus.loaded,
        ),
        act: (homeCubit) => homeCubit.loadRestaurants(),
        expect: () => <HomeState>[
          const HomeState(
            allRestaurantsStatus: HomeListStatus.loading,
          ),
          HomeState(
            allRestaurantsStatus: HomeListStatus.loaded,
            allRestaurants: List.generate(10, (index) => const Restaurant()),
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits completed status when restaurantRepository fetches the same'
        'quantity of restaurants',
        setUp: () {
          when(() => restaurantRepository.restaurants).thenAnswer(
            (_) =>
                Stream.value(List.generate(10, (index) => const Restaurant())),
          );
        },
        build: buildCubit,
        seed: () => HomeState(
          allRestaurantsStatus: HomeListStatus.loaded,
          allRestaurants: List.generate(10, (index) => const Restaurant()),
        ),
        act: (homeCubit) => homeCubit.loadRestaurants(),
        expect: () => <HomeState>[
          HomeState(
            allRestaurantsStatus: HomeListStatus.loading,
            allRestaurants: List.generate(10, (index) => const Restaurant()),
          ),
          HomeState(
            allRestaurantsStatus: HomeListStatus.completed,
            allRestaurants: List.generate(10, (index) => const Restaurant()),
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits error status when restaurantRepository throws an error',
        setUp: () {
          when(() => restaurantRepository.getRestaurants())
              .thenThrow(Exception());
        },
        build: buildCubit,
        seed: () => HomeState(
          allRestaurantsStatus: HomeListStatus.loaded,
          allRestaurants: List.generate(10, (index) => const Restaurant()),
        ),
        act: (homeCubit) => homeCubit.loadRestaurants(),
        expect: () => <HomeState>[
          HomeState(
            allRestaurantsStatus: HomeListStatus.loading,
            allRestaurants: List.generate(10, (index) => const Restaurant()),
          ),
          HomeState(
            allRestaurantsStatus: HomeListStatus.error,
            allRestaurants: List.generate(10, (index) => const Restaurant()),
          ),
        ],
      );
    });
  });
}
