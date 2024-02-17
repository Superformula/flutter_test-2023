import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/core/models/restaurant.dart';

part 'restaurant_event.dart';

part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc({required this.hiveHelper}) : super(RestaurantInitial()) {
    on<CheckFavoriteEvent>(_onCheckFavoriteEvent);
    on<AddFavoriteEvent>(_onAddFavoriteEvent);
    on<RemoveFavoriteEvent>(_onRemoveFavoriteEvent);
  }

  final HiveHelper hiveHelper;

  Future<void> _onCheckFavoriteEvent(
    CheckFavoriteEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(const LoadingState());
    try {
      List<String> favoriteIds = hiveHelper.getAllFavoriteIds();
      bool isFavorited = favoriteIds.contains(event.restaurant.id);

      emit(VerifiedState(isFavorited: isFavorited));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onAddFavoriteEvent(
    AddFavoriteEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(const LoadingState());
    try {
      await hiveHelper.addFavorite(event.restaurantId);
      emit(const VerifiedState(isFavorited: true));
    } catch (e) {
      emit(FavoriteOperationError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFavoriteEvent(
    RemoveFavoriteEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(const LoadingState());
    try {
      await hiveHelper.removeFavorite(event.restaurantId);
      emit(const VerifiedState(isFavorited: false));
    } catch (e) {
      emit(
        FavoriteOperationError(
          message: e.toString(),
        ),
      );
    }
  }
}
