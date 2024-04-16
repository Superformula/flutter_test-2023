import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/presentation/restaurant_list/bloc/bloc.dart';

void main() {
  test('verify GetRestaurantsListEvent is RestaurantListEvent', () {
    expect(GetRestaurantsListEvent(), isA<RestaurantListEvent>());
  });

  test('verify GetRestaurantsListEvent is equal to Equatable props', () {
    GetRestaurantsListEvent instance = GetRestaurantsListEvent();
    expect(instance.props.isEmpty, true);
  });
}
