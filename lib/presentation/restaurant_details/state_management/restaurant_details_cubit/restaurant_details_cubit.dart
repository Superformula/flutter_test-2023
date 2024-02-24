import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

part 'restaurant_details_cubit.freezed.dart';
part 'restaurant_details_state.dart';

@injectable
class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  RestaurantDetailsCubit() : super(const RestaurantDetailsState.initial());

  void initialize({required Restaurant restaurant}) {
    emit(RestaurantDetailsState.initial(restaurant: restaurant));
  }
}
