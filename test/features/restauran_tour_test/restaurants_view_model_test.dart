import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/features/restauran_tour/model/restauran_service.dart';
import 'package:restaurantour/features/restauran_tour/view_model/restaurants_view_model.dart';
import 'mock_restauran_service.dart';

void main() {
  late RestauranService restauranService;

  setUp(() {
    restauranService = MockRestauranService();
  });

  testWidgets('Check all restautant list got loaded',
      (WidgetTester tester) async {
    RestaurantsViewModel viewModel =
        RestaurantsViewModel(service: restauranService);

    //Intially make an api call to get all restaurant list
    await tester.pump(const Duration(seconds: 2));

    /// check if list got set to allRestaurants property.
    expect(viewModel.allRestaurants, isNotEmpty);
    expect(viewModel.allRestaurants.length, 2);

    /// Intially the favorite list should be empty
    expect(viewModel.favoriteRestaurants, isEmpty);

    ///Make sure load more should make an API call to append new list
    viewModel.loadMore();
    await tester.pump(const Duration(seconds: 2));

    ///check the list should be incremented after tapping on View more
    expect(viewModel.allRestaurants.length, 4);
  });

  testWidgets('check to add favourite', (WidgetTester tester) async {
    RestaurantsViewModel viewModel =
        RestaurantsViewModel(service: restauranService);

    //Intially make an api call to get all restaurant list
    await tester.pump(const Duration(seconds: 2));

    /// check if list got set to allRestaurants property.
    expect(viewModel.allRestaurants, isNotEmpty);

    /// Intially the favorite list should be empty
    expect(viewModel.favoriteRestaurants, isEmpty);

    /// adding the first item to favourite and it's name is "Lol"
    expect(viewModel.allRestaurants.first.name, "Lol");
    viewModel.addOrRemoveFavorite(viewModel.allRestaurants.first.id ?? "");

    /// check added item should be preset in favoriteRestaurants property
    expect(viewModel.favoriteRestaurants, isNotEmpty);
    expect(viewModel.favoriteRestaurants.length, 1);
    expect(viewModel.favoriteRestaurants.first.name, "Lol");
  });
}
