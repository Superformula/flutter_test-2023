part of 'favorites_cubit.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.loaded({
    required List<Restaurant> restaurants,
  }) = _Loaded;

  factory FavoritesState.fromJson(Map<String, dynamic> json) =>
      _$FavoritesStateFromJson(json);
}
