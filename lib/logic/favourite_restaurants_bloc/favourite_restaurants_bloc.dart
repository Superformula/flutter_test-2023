import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';

part 'favourite_restaurants_event.dart';
part 'favourite_restaurants_state.dart';

class FavouriteRestaurantsBloc
    extends HydratedBloc<FavouriteRestaurantsEvent, FavouriteRestaurantsState> {
  final YelpRepository yelpRepository;

  FavouriteRestaurantsBloc({required this.yelpRepository})
      : super(FavouriteRestaurantsInitial()) {
    List<Restaurant> favouriteRestaurants = [];

    on<FavRestaurant>((event, emit) async {
      favouriteRestaurants.add(event.restaurant);
      emit(FavouriteRestaurantsData(favouriteRestaurants));
    });

    on<UnfavRestaurant>((event, emit) {
      final int readIndex = favouriteRestaurants.indexWhere(
        (item) => item.id == event.restaurantId,
      );
      favouriteRestaurants.removeAt(readIndex);
      emit(FavouriteRestaurantsData(favouriteRestaurants));
    });

    on<LoadRestaurantsStatus>((event, emit) async {
      try {
        final futures = favouriteRestaurants
            .map((fav) => fav.id)
            .map(
              (id) => id != null
                  ? yelpRepository.getRestaurantStatus(
                      id,
                    )
                  : Future.value(null),
            )
            .toList();

        final responseData = await Future.wait(futures);
        responseData
            .where((r) => r != null && r.id != null && r.hours != null)
            .forEach((fav) {
          final index = favouriteRestaurants.indexWhere(
            (item) => fav!.id == item.id,
          );
          favouriteRestaurants[index] = favouriteRestaurants[index].copyWith(
            hours: fav!.hours,
          );
        });
      } on DioException catch (error) {
        emit(FavouriteRestaurantsError(error.message ?? error.toString()));
      } catch (error) {
        emit(FavouriteRestaurantsError(error.toString()));
      } finally {
        emit(FavouriteRestaurantsData(favouriteRestaurants));
      }
    });
  }

  @override
  FavouriteRestaurantsState? fromJson(Map<String, dynamic> json) {
    try {
      final String state = json['FavouriteRestaurantsState'] as String;
      switch (state) {
        case 'data':
          {
            final List<dynamic> data = jsonDecode(json["restaurantsList"]);
            final List<Restaurant> parsedList = data
                .map(
                  (dynamic item) =>
                      Restaurant.fromJson(item as Map<String, dynamic>),
                )
                .toList();
            return FavouriteRestaurantsData(parsedList);
          }
        default:
          return FavouriteRestaurantsInitial();
      }
    } catch (_) {
      return FavouriteRestaurantsInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(FavouriteRestaurantsState state) {
    try {
      if (state is FavouriteRestaurantsData) {
        final jsonList = state.restaurantsList.map((e) => e.toJson()).toList();
        return {
          "FavouriteRestaurantsState": "data",
          'restaurantsList': jsonEncode(jsonList),
        };
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
