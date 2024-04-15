import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/logic/restaurant_reviews_cubit/restaurant_reviews_cubit.dart';

import 'restaurant_reviews_cubit.test.mocks.dart';

@GenerateMocks([YelpRepository])
void main() {
  group('RestaurantReviewsCubit Success Cases', () {
    late MockYelpRepository mockYelpRepository;

    setUp(() {
      mockYelpRepository = MockYelpRepository();
    });

    blocTest<RestaurantReviewsCubit, RestaurantReviewsState>(
      'emits [RestaurantReviewsLoading], [RestaurantReviewsData] and [RestaurantReviewsIdle] when loadReviews is successfully called.',
      build: () {
        when(
          mockYelpRepository.getRestaurantReviews(
            restaurantId: anyNamed('restaurantId'),
          ),
        ).thenAnswer(
          (_) async => const ReviewQueryResult(
            reviewsList: [
              Review(id: '1', text: 'Great food', rating: 5),
              Review(id: '2', text: 'Awesome service', rating: 4),
            ],
            total: 2,
          ),
        );

        return RestaurantReviewsCubit(yelpRepository: mockYelpRepository);
      },
      act: (bloc) => bloc.loadReviews(restaurantId: '123'),
      expect: () => [
        isA<RestaurantReviewsLoading>(),
        isA<RestaurantReviewsData>()
          ..having(
            (p0) => p0.reviewsList,
            "List of Reviews",
            [
              const Review(id: '1', text: 'Great food', rating: 5),
              const Review(id: '2', text: 'Awesome service', rating: 4),
            ],
          ).having(
            (p0) => p0.reviewCount,
            "Reviews Count",
            2,
          ),
        isA<RestaurantReviewsIdle>(),
      ],
    );
  });

  group('RestaurantReviewsCubit Error Cases', () {
    late MockYelpRepository mockYelpRepository;

    setUp(() {
      mockYelpRepository = MockYelpRepository();
    });

    blocTest<RestaurantReviewsCubit, RestaurantReviewsState>(
      'emits [RestaurantReviewsLoading], [RestaurantReviewsError] and [RestaurantReviewsIdle] when getRestaurantReviews throw DioException.',
      build: () {
        when(
          mockYelpRepository.getRestaurantReviews(
            restaurantId: anyNamed('restaurantId'),
          ),
        ).thenThrow(DioException(message: "Failed to load reviews"));

        return RestaurantReviewsCubit(yelpRepository: mockYelpRepository);
      },
      act: (bloc) => bloc.loadReviews(restaurantId: '123'),
      expect: () => [
        isA<RestaurantReviewsLoading>(),
        isA<RestaurantReviewsError>()
          ..having(
            (p0) => p0.errorMessage,
            "Error message thrown by repository",
            "Failed to load reviews",
          ),
        isA<RestaurantReviewsIdle>(),
      ],
    );

    blocTest<RestaurantReviewsCubit, RestaurantReviewsState>(
      'emits [RestaurantReviewsLoading], [RestaurantReviewsError] and [RestaurantReviewsIdle] when getRestaurantReviews throw Exception.',
      build: () {
        when(
          mockYelpRepository.getRestaurantReviews(
            restaurantId: anyNamed('restaurantId'),
          ),
        ).thenThrow(Exception("Failed to load reviews"));

        return RestaurantReviewsCubit(yelpRepository: mockYelpRepository);
      },
      act: (bloc) => bloc.loadReviews(restaurantId: '123'),
      expect: () => [
        isA<RestaurantReviewsLoading>(),
        isA<RestaurantReviewsError>()
          ..having(
            (p0) => p0.errorMessage,
            "Error message thrown by repository",
            "Failed to load reviews",
          ),
        isA<RestaurantReviewsIdle>(),
      ],
    );
  });
}

class DioException {
  final String message;
  DioException({required this.message});
}
