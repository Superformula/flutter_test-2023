import 'package:bloc_test/bloc_test.dart';
import 'package:restaurantour/logic/favorites/favorites_cubit.dart';
import 'package:restaurantour/logic/restaurant/restaurant_bloc.dart';

class MockRestaurantBloc extends MockBloc<RestaurantEvent, RestaurantState>
    implements RestaurantBloc {}

class MockFavoritesCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}
