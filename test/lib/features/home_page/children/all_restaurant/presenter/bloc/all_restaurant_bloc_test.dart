import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/children/all_restaurant/presenter/bloc/all_restaurant/all_restaurant_bloc.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class MockYelpRepository extends Mock implements YelpRepository {}

class MockHiveHelper extends Mock implements HiveHelper {}

class MockDioException extends Mock implements DioException {}

var mockCategories = [
  Category(title: 'Italian', alias: 'italian'),
  Category(title: 'Mexican', alias: 'mexican'),
];

var mockReviews = [
  const Review(
    id: '3a2sd1',
    rating: 5,
    text: 'Amazing experience!',
    user: User(
      id: 'user1',
      name: 'John Doe',
      imageUrl: 'https://example.com/user1.jpg',
    ),
  ),
  const Review(
    id: '3a2sd1f3',
    rating: 4,
    text: 'Great food, will come again.',
    user: User(
      id: 'user2',
      name: 'Jane Smith',
      imageUrl: 'https://example.com/user2.jpg',
    ),
  ),
];

var mockRestaurants = [
  Restaurant(
    id: '1',
    name: 'Mock Italian Restaurant',
    rating: 4.5,
    photos: ['https://example.com/restaurant1.jpg'],
    categories: mockCategories,
    reviews: mockReviews,
  ),
  Restaurant(
    id: '2',
    name: 'Mock Mexican Restaurant',
    rating: 4.0,
    photos: ['https://example.com/restaurant2.jpg'],
    categories: mockCategories,
    reviews: mockReviews,
  ),
];

void main() {
  group(
    'AllRestaurantBloc',
    () {
      late YelpRepository yelpRepository;
      late AllRestaurantBloc allRestaurantBloc;
      late HiveHelper hiveHelper;

      setUp(() {
        yelpRepository = MockYelpRepository();
        hiveHelper = MockHiveHelper();
        allRestaurantBloc = AllRestaurantBloc(
          hiveHelper: hiveHelper,
          yelpRepository: yelpRepository,
        );

        registerFallbackValue(Uri());
      });

      blocTest<AllRestaurantBloc, AllRestaurantState>(
        'emits [LoadingState, DataLoadedState] when restaurants are fetched successfully',
        build: () {
          when(() => yelpRepository.getRestaurants()).thenAnswer(
            (_) async => Result.ok(
              RestaurantQueryResult(
                restaurants: mockRestaurants,
              ),
            ),
          );
          return allRestaurantBloc;
        },
        act: (bloc) => bloc.add(
          const IniEvent(),
        ),
        expect: () => [
          const LoadingState(),
          isA<DataLoadedState>(),
        ],
      );

      blocTest<AllRestaurantBloc, AllRestaurantState>(
        'emits [LoadingState, ErrorState] when fetching restaurants fails',
        build: () {
          final dioError = MockDioException();

          when(() => yelpRepository.getRestaurants()).thenAnswer(
            (_) async => Result.err(dioError),
          );
          return allRestaurantBloc;
        },
        act: (bloc) => bloc.add(const IniEvent()),
        expect: () => [
          const LoadingState(),
          isA<ErrorState>(),
        ],
      );
    },
  );
}
