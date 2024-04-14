import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

// YelpRepository provider
final yelpRepositoryProvider = Provider<YelpRepository>((ref) {
  return YelpRepository();
});

//Restuaurants Provider
class RestaurantsNotifier extends StateNotifier<AsyncValue<List<Restaurant>>> {
  final YelpRepository repository;

  RestaurantsNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchRestaurantsIfNeeded();
  }

  Future<void> fetchRestaurantsIfNeeded() async {
    if (state is! AsyncData) {
      fetchRestaurants();
    }
  }

  Future<void> fetchRestaurants() async {
    try {
      final result = await repository.getRestaurants();
      if (result != null && result.restaurants != null) {
        state = AsyncValue.data(result.restaurants!);
      } else {
        state = AsyncValue.error(
          Exception("No restaurants found"),
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(
        Exception('Failed to fetch restaurants: $e'),
        StackTrace.current,
      );
    }
  }
}

final restaurantsNotifierProvider =
    StateNotifierProvider<RestaurantsNotifier, AsyncValue<List<Restaurant>>>(
        (ref) {
  return RestaurantsNotifier(ref.watch(yelpRepositoryProvider));
});
