import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

part 'favorites_state.dart';
part 'favorites_cubit.g.dart';
part 'favorites_cubit.freezed.dart';

@injectable
class FavoritesCubit extends HydratedCubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState.loaded(restaurants: []));

  void addToFavorites({required Restaurant restaurant}) {
    final listOfFavorites = List<Restaurant>.from(
      state.maybeWhen(loaded: (restaurants) => restaurants, orElse: () => []),
    );
    if (!isFavorite(id: restaurant.id)) {
      listOfFavorites.add(restaurant);
      emit(FavoritesState.loaded(restaurants: listOfFavorites));
    }
  }

  void removeFromFavorites({required String? id}) {
    final listOfFavorites = List<Restaurant>.from(
      state.maybeWhen(loaded: (restaurants) => restaurants, orElse: () => []),
    );
    if (isFavorite(id: id)) {
      listOfFavorites.removeWhere((element) => element.id == id);
      emit(FavoritesState.loaded(restaurants: listOfFavorites));
    }
    emit(FavoritesState.loaded(restaurants: listOfFavorites));
  }

  bool isFavorite({required String? id}) {
    final listOfFavorites = List<Restaurant>.from(
      state.maybeWhen(loaded: (restaurants) => restaurants, orElse: () => []),
    );
    final index = listOfFavorites.indexWhere((element) => element.id == id);
    return index != -1;
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    return FavoritesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    return state.toJson();
  }
}
