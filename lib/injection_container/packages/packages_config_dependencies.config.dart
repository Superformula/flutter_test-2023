// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:api_client/api_client.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:restaurantour/injection_container/packages/modules/api_client/api_client_module.dart'
    as _i5;
import 'package:restaurantour/injection_container/packages/modules/restaurants_repository/restaurants_repository_module.dart'
    as _i6;
import 'package:restaurants_repository/restaurants_repository.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final restApiServiceModule = _$RestApiServiceModule();
  final restaurantsRepositoryModule = _$RestaurantsRepositoryModule();
  await gh.singletonAsync<_i3.ApiClient>(
    () => restApiServiceModule.apliClientService(),
    preResolve: true,
  );
  gh.singleton<_i4.RestaurantsRepositoryContract>(
      restaurantsRepositoryModule.restaurantsRepository(get<_i3.ApiClient>()));
  return get;
}

class _$RestApiServiceModule extends _i5.RestApiServiceModule {}

class _$RestaurantsRepositoryModule extends _i6.RestaurantsRepositoryModule {}
