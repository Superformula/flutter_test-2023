import '../../models/restaurant.dart';

abstract class RestaurantsState {
  const RestaurantsState();
}

class RestaurantsLoading extends RestaurantsState {
  const RestaurantsLoading();
}

class RestaurantsLoaded extends RestaurantsState {
  const RestaurantsLoaded(
    this.restaurants,
    this.offSet,
  );

  final List<Restaurant>? restaurants;
  final int offSet;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantsLoaded &&
          runtimeType == other.runtimeType &&
          restaurants == other.restaurants &&
          offSet == other.offSet;

  @override
  int get hashCode => restaurants.hashCode ^ offSet.hashCode;

  RestaurantsLoaded copyWith({
    List<Restaurant>? restaurants,
    int? offSet,
  }) {
    return RestaurantsLoaded(
      restaurants ?? this.restaurants,
      offSet ?? this.offSet,
    );
  }
}

class RestaurantsLoadedAndFetchingMore extends RestaurantsLoaded {
  const RestaurantsLoadedAndFetchingMore(
    super.restaurants,
    super.offSet,
  );
}

class RestaurantsFetchError extends RestaurantsState {}
