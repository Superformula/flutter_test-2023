import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/domain/restaurants/restaurants.dart';

part 'restaurant_details_cubit.freezed.dart';
part 'restaurant_details_state.dart';

@injectable
class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  RestaurantDetailsCubit() : super(const RestaurantDetailsState.initial());

  void initialize({required RestaurantEntity restaurant}) {
    emit(RestaurantDetailsState.loaded(restaurant: restaurant));
  }
}
