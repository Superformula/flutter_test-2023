import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/logic/restaurants_bloc/restaurants_bloc.dart';

import 'restaurants_bloc.test.mocks.dart';

@GenerateMocks([YelpRepository])
void main() {
  group('RestaurantsBloc Success Cases', () {
    late MockYelpRepository mockYelpRepository;

    setUp(() {
      mockYelpRepository = MockYelpRepository();
    });

    blocTest<RestaurantsBloc, RestaurantsState>(
      'emits [RestaurantsLoading] and [RestaurantsData] when LoadRestaurants event is added.',
      build: () {
        when(
          mockYelpRepository.getRestaurants(),
        ).thenAnswer(
          (_) async => const RestaurantQueryResult(
            restaurants: [
              Restaurant(
                id: 'jsfielsslfqxo0',
                name: 'Great food Restaurant',
                rating: 5.0,
              ),
              Restaurant(
                id: 'uejdpqd911jdu8',
                name: 'Gordons Service Food',
                rating: 4.3,
              ),
            ],
            total: 2,
          ),
        );

        return RestaurantsBloc(yelpRepository: mockYelpRepository);
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        isA<RestaurantsLoading>(),
        isA<RestaurantsData>()
          ..having(
            (p0) => p0.restaurantsList,
            "List of Restaurants",
            const [
              Restaurant(
                id: 'jsfielsslfqxo0',
                name: 'Great food Restaurant',
                rating: 5.0,
              ),
              Restaurant(
                id: 'uejdpqd911jdu8',
                name: 'Gordons Service Food',
                rating: 4.3,
              ),
            ],
          ),
      ],
    );
  });

  group('RestaurantsBloc Error Cases', () {
    late MockYelpRepository mockYelpRepository;

    setUp(() {
      mockYelpRepository = MockYelpRepository();
    });

    blocTest<RestaurantsBloc, RestaurantsState>(
      'emits [RestaurantsLoading], [RestaurantsError] and [RestaurantsData] when LoadRestaurants event is added and getRestaurants throw DioException.',
      build: () {
        when(
          mockYelpRepository.getRestaurants(),
        ).thenThrow(DioException(message: "Failed to load restaurants list"));

        return RestaurantsBloc(yelpRepository: mockYelpRepository);
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        isA<RestaurantsLoading>(),
        isA<RestaurantsError>()
          ..having(
            (p0) => p0.errorMessage,
            "Error message thrown by repository",
            "Failed to load reviews",
          ),
        isA<RestaurantsData>()
          ..having(
            (p0) => p0.restaurantsList,
            "List of restaurants",
            [],
          ),
      ],
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'emits [RestaurantsLoading], [RestaurantsError] and [RestaurantsData] when LoadRestaurants event is added and getRestaurants throw Exception.',
      build: () {
        when(
          mockYelpRepository.getRestaurants(),
        ).thenThrow(Exception("Failed to load restaurants list"));

        return RestaurantsBloc(yelpRepository: mockYelpRepository);
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        isA<RestaurantsLoading>(),
        isA<RestaurantsError>()
          ..having(
            (p0) => p0.errorMessage,
            "Error message thrown by repository",
            "Failed to load reviews",
          ),
        isA<RestaurantsData>()
          ..having(
            (p0) => p0.restaurantsList,
            "List of restaurants",
            [],
          ),
      ],
    );
  });
}

class DioException {
  final String message;
  DioException({required this.message});
}
