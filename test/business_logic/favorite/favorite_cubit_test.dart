import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/business_logic/favorite/favorite_cubit.dart';
import 'package:restaurantour/business_logic/favorite/favorite_state.dart';

class FakeRestaurant extends Fake implements Restaurant {}

Restaurant _restaurant = Restaurant(
  categories: const [Category(title: 'Italiano'), Category(title: 'Mexicano')],
  photos: const [
    "https://s3-media2.fl.yelpcdn.com/bphoto/FxmtjuzPDiL7vx5KyceWuQ/o.jpg",
  ],
  hours: const [Hours(isOpenNow: true)],
  location: Location(formattedAddress: 'casa doparaguai'),
  id: '1',
  name: 'boteco da bruxa',
  price: 'bem caro',
  rating: 4.4,
  reviews: const [
    Review(id: '1234', rating: 4, user: User(name: 'Guilherme')),
  ],
);

void main() {
  late FavoriteCubit favoriteCubit;

  setUp(() {
    favoriteCubit = FavoriteCubit();
    registerFallbackValue(FakeRestaurant);
  });

  tearDown(() {
    favoriteCubit.close();
  });

  tearDownAll(() {
    favoriteCubit.close();
  });

  group('Favorite Restaurant function test', () {
    blocTest<FavoriteCubit, FavoriteState>(
      'Should emit favoriteSuccess and Success when an address is added to empty list ',
      build: () => favoriteCubit,
      act: (cubit) => cubit.favoriteRestaurant(_restaurant),
      expect: () => <FavoriteState>[
        FavoriteState(status: FavoriteStatus.favoriteSuccess),
        FavoriteState(status: FavoriteStatus.success, favorites: [_restaurant]),
      ],
    );
    blocTest<FavoriteCubit, FavoriteState>(
      'When removing last address should emit an empty list and removed and initial states ',
      build: () => favoriteCubit,
      seed: () => FavoriteState(favorites: [_restaurant]),
      act: (cubit) => favoriteCubit.favoriteRestaurant(_restaurant),
      expect: () => <dynamic>[
        isA<FavoriteState>()
            .having((f) => f.status, 'status', FavoriteStatus.removed)
            .having((f) => f.favorites, 'favorites', []),
        FavoriteState(status: FavoriteStatus.initial),
      ],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'Should remove an already added address ',
      build: () => favoriteCubit,
      seed: () => FavoriteState(
        favorites: [
          const Restaurant(id: '1', name: 'Breaking bad'),
          const Restaurant(id: '2', name: 'Better call saul'),
        ],
      ),
      act: (cubit) {
        const restaurant = Restaurant(id: '1', name: 'Breaking bad');

        cubit.favoriteRestaurant(restaurant);

        return cubit;
      },
      expect: () => <dynamic>[
        isA<FavoriteState>()
            .having((f) => f.status, 'status', FavoriteStatus.removed)
            .having(
          (f) => f.favorites,
          'favorites',
          const [Restaurant(id: '2', name: 'Better call saul')],
        ),
        isA<FavoriteState>()
            .having((f) => f.status, 'status', FavoriteStatus.success)
            .having(
          (f) => f.favorites,
          'favorites',
          const [Restaurant(id: '2', name: 'Better call saul')],
        ),
      ],
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'Shoudl emit failure state when restaurant has empty id.',
      build: () => favoriteCubit,
      act: (cubit) => cubit.favoriteRestaurant(const Restaurant(id: null)),
      expect: () => [
        FavoriteState(
          status: FavoriteStatus.failure,
          errorMessage:
              'Could favorite this restaurant! Refresh the app to try again! ',
        ),
      ],
    );
  });

  group('Load favorites Restaurants test', () {
    blocTest<FavoriteCubit, FavoriteState>(
      'Emit inital state when user not favorited any',
      build: () => favoriteCubit,
      act: (cubit) => cubit.loadFavorites(),
      expect: () => <dynamic>[
        FavoriteState(status: FavoriteStatus.loading),
        FavoriteState(status: FavoriteStatus.initial),
      ],
    );
  });

  blocTest<FavoriteCubit, FavoriteState>(
    'Emit success state when user not favorited any',
    seed: () => FavoriteState(
      favorites: [
        const Restaurant(id: '1', name: 'Better call saul'),
      ],
    ),
    build: () => favoriteCubit,
    act: (cubit) => cubit.loadFavorites(),
    expect: () => <dynamic>[
      isA<FavoriteState>().having(
        (f) => f.status,
        'status',
        FavoriteStatus.loading,
      ),
      isA<FavoriteState>()
          .having(
            (f) => f.status,
            'status',
            FavoriteStatus.success,
          )
          .having(
            (f) => f.favorites.first,
            'favorites',
            const Restaurant(id: '1', name: 'Better call saul'),
          ),
    ],
  );
}
