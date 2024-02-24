// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:restaurantour/presentation/app/state_management/pagination_cubit/pagination_cubit.dart'
    as _i6;
import 'package:restaurantour/presentation/home/state_management/home_cubit/home_cubit.dart'
    as _i3;
import 'package:restaurantour/presentation/home/state_management/home_tab_controller_cubit/home_tab_controller_cubit.dart'
    as _i5;
import 'package:restaurantour/presentation/restaurant_details/state_management/restaurant_details_cubit/restaurant_details_cubit.dart'
    as _i8;
import 'package:restaurants_repository/restaurants_repository.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.HomeCubit>(
      () => _i3.HomeCubit(get<_i4.RestaurantsRepositoryContract>()));
  gh.factory<_i5.HomeTabControllerCubit>(() => _i5.HomeTabControllerCubit());
  gh.factory<_i6.PaginationCubit<dynamic>>(() => _i6.PaginationCubit<dynamic>(
        pagingController: get<_i7.PagingController<int, dynamic>>(),
        fetchItemCallBack: get<_i6.FetchItemCallBack>(),
        sort: get<String>(),
        itemsPerPage: get<int>(),
        filters: get<Map<String, dynamic>>(),
      ));
  gh.factory<_i8.RestaurantDetailsCubit>(() => _i8.RestaurantDetailsCubit());
  return get;
}
