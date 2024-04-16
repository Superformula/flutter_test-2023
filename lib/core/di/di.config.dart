// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:restaurantour/core/di/dio_module.dart' as _i14;
import 'package:restaurantour/core/http_service/dio_http_service/dio_http_service.dart'
    as _i6;
import 'package:restaurantour/core/http_service/http_service.dart' as _i5;
import 'package:restaurantour/data/datasources/datasources.dart' as _i10;
import 'package:restaurantour/data/datasources/restaurant/restaurant_datasource.dart'
    as _i7;
import 'package:restaurantour/data/repositories/restaurant/restaurant_repository_implementation.dart'
    as _i9;
import 'package:restaurantour/domain/repositories/repositories.dart' as _i8;
import 'package:restaurantour/domain/usecases/restaurant/get_restaurants_list_usecase.dart'
    as _i11;
import 'package:restaurantour/domain/usecases/usecases.dart' as _i13;
import 'package:restaurantour/presentation/restaurant_detail/cubit/favorite_restaurants_list_cubit.dart'
    as _i4;
import 'package:restaurantour/presentation/restaurant_list/bloc/restaurant_list_bloc.dart'
    as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.lazySingleton<_i3.Dio>(() => dioModule.dio());
    gh.singleton<_i4.FavoriteRestaurantsCubit>(
        () => _i4.FavoriteRestaurantsCubit());
    gh.lazySingleton<_i5.HttpService>(() => _i6.DioHttpService(gh<_i3.Dio>()));
    gh.lazySingleton<_i7.RestaurantDatasource>(
        () => _i7.RestaurantDatasourceImpl(client: gh<_i5.HttpService>()));
    gh.lazySingleton<_i8.RestaurantRepository>(() =>
        _i9.RestaurantRepositoryImplementation(
            restaurantDatasource: gh<_i10.RestaurantDatasource>()));
    gh.lazySingleton<_i11.GetRestaurantsListUsecase>(() =>
        _i11.GetRestaurantsListUsecase(
            restaurantRepository: gh<_i8.RestaurantRepository>()));
    gh.factory<_i12.RestaurantListBloc>(() => _i12.RestaurantListBloc(
        getRestaurantsListUsecase: gh<_i13.GetRestaurantsListUsecase>()));
    return this;
  }
}

class _$DioModule extends _i14.DioModule {}
