import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final YelpRepository yelpRepository;

  RestaurantsBloc({required this.yelpRepository})
      : super(RestaurantsInitial()) {
    List<Restaurant> restaurantsList = [];

    on<LoadRestaurants>((event, emit) async {
      try {
        emit(RestaurantsLoading());
        final responseData = await yelpRepository.getRestaurants(
          offset: event.offset ?? 0,
        );
        final fetchedRestaurants = responseData?.restaurants ?? [];
        restaurantsList.addAll(fetchedRestaurants);
      } on DioException catch (error) {
        emit(RestaurantsError(error.message ?? error.toString()));
      } catch (error) {
        emit(RestaurantsError(error.toString()));
      } finally {
        emit(RestaurantsData(restaurantsList));
      }
    });
  }
}
