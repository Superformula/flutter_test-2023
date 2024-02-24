import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/presentation/app/state_management/favorites_cubit/favorites_cubit.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

import '../../../../helpers/helpers.dart';

void main() {
  initHydratedStorage();

  group('FavoritesCubit', () {
    const restaurant1 = Restaurant(
      id: 'id1',
      name: 'Restaurant name',
      price: '10',
      categories: [
        Category(alias: 'Category alias', title: 'Category title'),
      ],
      hours: [
        Hours(isOpenNow: true),
      ],
    );
    const restaurant2 = Restaurant(
      id: 'id2',
      name: 'Restaurant name',
      price: '10',
      categories: [
        Category(alias: 'Category alias', title: 'Category title'),
      ],
      hours: [
        Hours(isOpenNow: false),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'add restaurant to favorites list when its empty',
      build: () => FavoritesCubit(),
      act: (bloc) => bloc.addToFavorites(restaurant: restaurant1),
      expect: () => [
        isA<FavoritesState>().having(
          (element) => element.restaurants,
          'restaurants',
          equals([restaurant1]),
        ),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'add restaurant to favorites list when its not empty',
      build: () => FavoritesCubit(),
      seed: () => const FavoritesState.loaded(restaurants: [restaurant1]),
      act: (bloc) => bloc.addToFavorites(restaurant: restaurant2),
      expect: () => [
        isA<FavoritesState>().having(
          (element) => element.restaurants,
          'restaurants',
          equals([restaurant1, restaurant2]),
        ),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'try to add an already favorite restaurant',
      build: () => FavoritesCubit(),
      seed: () => const FavoritesState.loaded(restaurants: [restaurant1]),
      act: (bloc) => bloc.addToFavorites(restaurant: restaurant1),
      expect: () => [],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'remove existing restaurant from favorites list',
      build: () => FavoritesCubit(),
      seed: () => const FavoritesState.loaded(restaurants: [restaurant1]),
      act: (bloc) => bloc.removeFromFavorites(id: restaurant1.id),
      expect: () => [
        isA<FavoritesState>().having(
          (element) => element.restaurants,
          'restaurants',
          equals([]),
        ),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'try to remove not existing restaurant from favorites list',
      build: () => FavoritesCubit(),
      seed: () => const FavoritesState.loaded(restaurants: [restaurant1]),
      act: (bloc) => bloc.removeFromFavorites(id: restaurant2.id),
      expect: () => [],
    );
  });
}
