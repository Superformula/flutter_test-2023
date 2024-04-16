import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/presentation/restaurant_list/bloc/bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(
      const FavoriteRestaurantsListState(),
      const FavoriteRestaurantsListState(),
    );
  });

  test('copy attributes', () {
    final FavoriteRestaurantsListState state =
        const FavoriteRestaurantsListState().copyWith();
    expect(state, isA<FavoriteRestaurantsListState>());
    expect(state, equals(const FavoriteRestaurantsListState()));
    expect(state.props.isNotEmpty, true);
  });
}
