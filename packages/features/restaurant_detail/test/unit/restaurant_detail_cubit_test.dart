import 'package:bloc_test/bloc_test.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/local_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_detail/src/restaurant_detail_cubit.dart';
import 'package:yelp_repository/yelp_repository.dart';

import 'restaurant_detail_cubit_test.mocks.dart';

@GenerateMocks([YelpRepository, LocalStorage])
void main() {
  final yelpRepository = MockYelpRepository();
  final localStorage = MockLocalStorage();
  const restaurant = Restaurant(
    id: 'id',
    name: 'name',
    price: 'price',
    rating: 4.3,
    photoUrl: 'photoUrl',
    category: 'category',
    isOpen: true,
    address: 'address',
  );
  const review = Review(
    id: 'id',
    rating: 2,
    text: 'text',
    user: User(
      name: 'name',
      imageUrl: 'imageUrl',
    ),
  );

  final reviews = List.generate(
    21,
    (index) => review.copyWith(id: '$index'),
  );

  group('RestaurantDetailCubit.getReviews', () {
    setUp(() {
      when(yelpRepository.getReviews(
        restaurantId: anyNamed('restaurantId'),
        offset: anyNamed('offset'),
      )).thenAnswer((_) => Future.value([review]));
    });

    tearDown(() {
      reset(yelpRepository);
      reset(localStorage);
      resetMockitoState();
    });

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      'getReviews success',
      build: () => RestaurantDetailCubit(
        yelpRepository: yelpRepository,
        localStorage: localStorage,
        restaurant: restaurant,
      ),
      act: (cubit) => cubit.getReviews(),
      verify: (_) {
        verify(yelpRepository.getReviews(
          restaurantId: restaurant.id,
          offset: 0,
        )).called(1);
      },
      expect: () => const [
        RestaurantDetailState(
          pageStatus: PageStatus.success,
          pageIndex: 1,
          reviews: [review],
          isLastPage: true,
        ),
      ],
    );

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      'getReviews more than one page success',
      build: () => RestaurantDetailCubit(
        yelpRepository: yelpRepository,
        localStorage: localStorage,
        restaurant: restaurant,
      ),
      setUp: () {
        when(yelpRepository.getReviews(
          restaurantId: anyNamed('restaurantId'),
          offset: anyNamed('offset'),
        )).thenAnswer((_) => Future.value(reviews));
      },
      act: (cubit) async {
        await cubit.getReviews();
        await cubit.getReviews();
        return cubit;
      },
      verify: (_) {
        verify(yelpRepository.getReviews(
          restaurantId: restaurant.id,
          offset: 0,
        )).called(1);
      },
      expect: () => [
        RestaurantDetailState(
          pageStatus: PageStatus.success,
          pageIndex: 1,
          reviews: reviews,
          isLastPage: false,
        ),
        RestaurantDetailState(
          pageStatus: PageStatus.success,
          pageIndex: 2,
          reviews: reviews,
          isLastPage: false,
        ),
      ],
    );

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      'getReviews error',
      setUp: () {
        when(yelpRepository.getReviews(
          restaurantId: anyNamed('restaurantId'),
          offset: anyNamed('offset'),
        )).thenThrow(Exception());
      },
      build: () => RestaurantDetailCubit(
        yelpRepository: yelpRepository,
        localStorage: localStorage,
        restaurant: restaurant,
      ),
      act: (cubit) => cubit.getReviews(),
      verify: (_) {
        verify(yelpRepository.getReviews(
          restaurantId: restaurant.id,
          offset: 0,
        )).called(1);
      },
      expect: () => const [
        RestaurantDetailState(
          pageStatus: PageStatus.error,
          pageIndex: 0,
          reviews: [],
          isLastPage: false,
        ),
      ],
    );
  });

  group('RestaurantDetailCubit toggle FavoriteRestaurant', () {
    setUp(() {
      when(localStorage.addRestaurant(restaurant)).thenReturn(1);
      when(localStorage.removeRestaurant(any)).thenReturn(true);
    });

    tearDown(() {
      reset(yelpRepository);
      reset(localStorage);
      resetMockitoState();
    });

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      'addFavoriteRestaurant',
      build: () => RestaurantDetailCubit(
        yelpRepository: yelpRepository,
        localStorage: localStorage,
        restaurant: restaurant,
      ),
      act: (cubit) => cubit.addFavoriteRestaurant(),
      verify: (_) => verify(localStorage.addRestaurant(restaurant)).called(1),
    );

    blocTest<RestaurantDetailCubit, RestaurantDetailState>(
      'removeFavoriteRestaurant',
      build: () => RestaurantDetailCubit(
        yelpRepository: yelpRepository,
        localStorage: localStorage,
        restaurant: restaurant,
      ),
      act: (cubit) => cubit.removeFavoriteRestaurant(),
      verify: (_) =>
          verify(localStorage.removeRestaurant(restaurant.id)).called(1),
    );
  });

  group('isFavoriteRestaurant stream', () {
    setUp(() => when(localStorage.containsRestaurantListener(restaurant.id!))
        .thenAnswer((_) => Stream.value(true)));

    tearDown(() {
      reset(yelpRepository);
      reset(localStorage);
      resetMockitoState();
    });

    // Errors with the stream are hanlded in the screen
    test(
      'consume isFavoriteRestaurant stream',
      () {
        final cubit = RestaurantDetailCubit(
          yelpRepository: yelpRepository,
          localStorage: localStorage,
          restaurant: restaurant,
        );

        expectLater(
          cubit.isFavoriteRestaurant,
          emitsInOrder(<bool>[true]),
        );
      },
    );
  });
}
