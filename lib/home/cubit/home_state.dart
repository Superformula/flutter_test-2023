part of 'home_cubit.dart';

enum HomeListStatus {
  initial,
  loading,
  loaded,
  completed,
  error,
}

class HomeState extends Equatable {
  const HomeState({
    this.allRestaurantsStatus = HomeListStatus.initial,
    this.favoritesStatus = HomeListStatus.initial,
    this.allRestaurants = const [],
    this.favorites = const [],
  });
  final HomeListStatus allRestaurantsStatus;
  final HomeListStatus favoritesStatus;
  final List<Restaurant> allRestaurants;
  final List<Restaurant> favorites;
  @override
  List<Object> get props =>
      [allRestaurantsStatus, favoritesStatus, allRestaurants, favorites];

  HomeState copyWith({
    HomeListStatus? allRestaurantsStatus,
    HomeListStatus? favoritesStatus,
    List<Restaurant>? allRestaurants,
    List<Restaurant>? favorites,
  }) {
    return HomeState(
      allRestaurantsStatus: allRestaurantsStatus ?? this.allRestaurantsStatus,
      favoritesStatus: favoritesStatus ?? this.favoritesStatus,
      allRestaurants: allRestaurants ?? this.allRestaurants,
      favorites: favorites ?? this.favorites,
    );
  }
}
