part of 'home_tab_controller_cubit.dart';

@freezed
class HomeTabControllerState with _$HomeTabControllerState {
  const factory HomeTabControllerState.allRestaurants() = _AllRestaurants;
  const factory HomeTabControllerState.myFavorites() = _MyFavorites;
}
