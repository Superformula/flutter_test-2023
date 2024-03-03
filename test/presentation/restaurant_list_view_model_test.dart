import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/presentation/restaurants/restaurant_list/restaurant_list_view_model.dart';

import '../test_utils/mocks.mocks.dart';

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
    });

    test('init should get restaurants and listen to favorites', () async {
      viewModel.init();

      expect(viewModel.isLoading, true);
      verify(mockGetRestaurantsUseCase(0)).called(1);
      verify(mockWatchFavoriteRestaurantsUseCase()).called(1);
    });

    test('get restaurants should get more restaurants', () async {
      await viewModel.getRestaurants();
      verify(mockGetRestaurantsUseCase(0)).called(1);
    });
  });
}
