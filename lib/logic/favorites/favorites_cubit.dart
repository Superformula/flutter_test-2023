import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurantour/models/models.dart';

part 'favorites_cubit.freezed.dart';
part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggleFavorite({required Restaurant restaurant}) {
    if(state.restaurants.contains(restaurant)){
      _removeFavorite(restaurant: restaurant); 
    }
    else {
      _addFavorite(restaurant: restaurant);
    }
  }

  void _addFavorite({required Restaurant restaurant}) {
    emit(state.copyWith(restaurants: [...state.restaurants, restaurant]));
  }

  void _removeFavorite({required Restaurant restaurant}) {
    final updatedList = [
      ...state.restaurants.where((element) => element != restaurant),
    ];
    emit(state.copyWith(restaurants: updatedList));
  }
}
