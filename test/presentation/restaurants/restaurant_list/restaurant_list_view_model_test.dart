import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_list/restaurant_list_view_model.dart';

import '../../../test_utils/mocks.mocks.dart';

void main() {
  group('$RestaurantListViewModel', () {
    late MockGetRestaurantsUseCase mockGetRestaurantsUseCase;
    late MockWatchFavoriteRestaurantsUseCase
        mockWatchFavoriteRestaurantsUseCase;
    late RestaurantListViewModel viewModel;
    setUp(() {
      mockGetRestaurantsUseCase = MockGetRestaurantsUseCase();
      mockWatchFavoriteRestaurantsUseCase =
          MockWatchFavoriteRestaurantsUseCase();
      viewModel = RestaurantListViewModel(
        mockGetRestaurantsUseCase,
        mockWatchFavoriteRestaurantsUseCase,
      );
      when(mockGetRestaurantsUseCase(0)).thenAnswer(
        (_) async => [
          const RestaurantEntity(
            id: 'abc',
            name: 'abc',
            heroImage: 'heroImage',
            price: 'price',
            rating: 5.0,
            category: 'category',
            address: 'address',
            isOpen: false,
            reviews: [],
          ),
        ],
      );
    });

    test('init should get restaurants and listen to favorites', () async {
      viewModel.init();

      expect(viewModel.isLoading, true);
      verify(mockGetRestaurantsUseCase(0)).called(1);
      verify(mockWatchFavoriteRestaurantsUseCase()).called(1);

      await Future.delayed(Duration.zero);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasData, true);
      expect(viewModel.restaurants.length, 1);
    });
  });
}
