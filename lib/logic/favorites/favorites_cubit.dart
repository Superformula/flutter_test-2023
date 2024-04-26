import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurantour/models/models.dart';

part 'favorites_cubit.freezed.dart';
part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  bool isFavorite(Restaurant restaurant) =>
      state.restaurants.contains(restaurant);

  void addFavorite({required Restaurant restaurant}) {
    emit(state.copyWith(restaurants: [...state.restaurants, restaurant]));
  }

  void removeFavorite({required Restaurant restaurant}) {
    final updatedList = [
      ...state.restaurants.where((element) => element != restaurant),
    ];
    emit(state.copyWith(restaurants: updatedList));
  }
}
