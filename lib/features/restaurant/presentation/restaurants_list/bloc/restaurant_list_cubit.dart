import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_favorites_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_restaurants_use_case.dart';

part 'restaurant_list_state.dart';

class RestaurantListCubit extends Cubit<RestaurantListState> {
  RestaurantListCubit() : super(RestaurantListLoading());

  final getRestaurantsUseCase = GetIt.instance<GetRestaurantsUseCase>();
  final getFavoriteRestaurantsUseCase =
      GetIt.instance<GetFavoriteRestaurantsUseCase>();

  void fetchRestaurants() async {
    emit(RestaurantListLoading());
    emit(RestaurantListLoaded([restaurantMockup]));
  }

  void fetchFavoriteRestaurants() async {
    emit(RestaurantListLoading());
    try {
      final favoriteRestaurants = await getFavoriteRestaurantsUseCase.call();
      emit(FavoriteRestaurantsLoaded(favoriteRestaurants));
    } catch (e) {
      emit(RestaurantListError(e.toString()));
    }
  }
}

Restaurant restaurantMockup = Restaurant(
  id: '1',
  name: 'Gordon Ramsay Hell\'s Kitchen',
  price: '\$\$\$',
  rating: 4.5,
  photos: [
    'https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg',
  ],
  categories: [
    Category(alias: 'newamerican', title: 'New American'),
  ],
  hours: [const Hours(isOpenNow: true)],
  reviews: [
    const Review(
      id: '1',
      rating: 5,
      user: User(
        id: '1',
        imageUrl: 'https://s3-media2.fl.yelpcdn.com/photo/1.jpg',
        name: 'John Doe',
      ),
    ),
  ],
  location: Location(formattedAddress: '123 Example St, City'),
);
