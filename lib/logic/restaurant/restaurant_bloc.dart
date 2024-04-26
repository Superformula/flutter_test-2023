import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurantour/models/models.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

part 'restaurant_bloc.freezed.dart';
part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final YelpRepository yelpRepository;

  RestaurantBloc({required this.yelpRepository}) : super(const _Initial()) {
    on<_GetRestaurants>((event, emit) async {
      emit(const RestaurantState.loading());
      try {
        final restaurants = await yelpRepository.getRestaurants(
          offset: event.offset,
        );
        emit(RestaurantState.success(restaurants: restaurants));
      } catch (e) {
        emit(const RestaurantState.error(message: "API daily quota reached"));
      }
    });
  }
}
