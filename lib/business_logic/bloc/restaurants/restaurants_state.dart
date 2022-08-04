import '../../../models/restaurant.dart';

abstract class RestaurantsState {
  const RestaurantsState();
}

class RestaurantsLoadInProgress extends RestaurantsState {
  const RestaurantsLoadInProgress();
}

class RestaurantsLoadSuccess extends RestaurantsState {
  const RestaurantsLoadSuccess(
    this.restaurants,
    this.offSet,
  );

  static const empty = RestaurantsLoadSuccess(<Restaurant>[], 0);

  final List<Restaurant> restaurants;
  final int offSet;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantsLoadSuccess &&
          runtimeType == other.runtimeType &&
          restaurants == other.restaurants &&
          offSet == other.offSet;

  @override
  int get hashCode => restaurants.hashCode ^ offSet.hashCode;

  RestaurantsLoadSuccess copyWith({
    List<Restaurant>? restaurants,
    int? offSet,
  }) {
    return RestaurantsLoadSuccess(
      restaurants ?? this.restaurants,
      offSet ?? this.offSet,
    );
  }
}

class RestaurantsLoadedAndFetchingMore extends RestaurantsLoadSuccess {
  const RestaurantsLoadedAndFetchingMore(
    super.restaurants,
    super.offSet,
  );
}

class RestaurantsFetchFailure extends RestaurantsState {}
