import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/data/remote_restaurant_datasource.dart';
import 'package:restaurantour/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurantour/features/restaurant/domain/use_cases/get_restaurants_use_case.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/bloc/restaurant_list_cubit.dart';

export 'package:restaurantour/features/restaurant/presentation/restaurant_details/restaurant_details_page.dart';
export 'package:restaurantour/features/restaurant/presentation/restaurants_list/restaurant_list_page.dart';

final _getIt = GetIt.instance;

void initRestaurantDependecies() {
  _initDataSources();
  _initRepositories();
  _initUseCases();
  _initBlocs();
}

void _initDataSources() {
  _getIt.registerFactory<RemoteRestaurantDataSource>(
    () => RemoteRestaurantDataSourceImpl(),
  );
}

void _initRepositories() {
  _getIt
      .registerFactory<RestaurantRepository>(() => RestaurantRepositoryImpl());
}

void _initUseCases() {
  _getIt.registerFactory<GetRestaurantsUseCase>(() => GetRestaurantsUseCase());
}

void _initBlocs() {
  _getIt.registerFactory<RestaurantListCubit>(() => RestaurantListCubit());
}
