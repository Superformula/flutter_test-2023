// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../blocs/restaurants/restaurants_cubit.dart' as _i4;
import '../../data/data.dart' as _i5;
import '../../data/repositories/yelp_repository.dart' as _i6;
import 'injectable_modules.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModules = _$InjectableModules();
  gh.lazySingleton<_i3.Dio>(() => injectableModules.dio);
  gh.factory<_i4.RestaurantsCubit>(
      () => _i4.RestaurantsCubit(get<_i5.YelpRepository>()));
  gh.lazySingleton<_i6.YelpRepository>(
      () => _i6.YelpRepository(get<_i3.Dio>()));
  return get;
}

class _$InjectableModules extends _i7.InjectableModules {}
