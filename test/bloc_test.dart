import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/domain/repositories/mock/mock_favorite_repository.dart';
import 'package:restaurantour/domain/repositories/mock/mock_restaurants_repository.dart';
import 'package:restaurantour/domain/usercases/favorites_usercase.dart';
import 'package:restaurantour/domain/usercases/restaurants_usercase.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';

void main() {
  group('Restaurants Test', () {
    late RestaurantsBloc restaurantsBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      final mockRestaurantsUsercase = RestaurantsUsercase(
        MockRestaurantsRepository(),
      );
      final mockFavoritesUsercase = FavoritesUsercase(MockFavoriteRepository());
      restaurantsBloc = RestaurantsBloc(
        mockRestaurantsUsercase,
        mockFavoritesUsercase,
      );
    });

    blocTest<RestaurantsBloc, RestaurantsState>(
      'get restaurants',
      build: () => restaurantsBloc,
      act: (bloc) => bloc.add(const FetchRestaurants("Las Vegas")),
      expect: () => <RestaurantsState>[
        RestaurantsLoading(),
        const RestaurantsLoaded(mockRestaurants),
      ],
    );

    tearDown(() => restaurantsBloc.close());
  });
}
