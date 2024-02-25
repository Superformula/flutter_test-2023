import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/domain/restaurants/restaurants.dart';
import 'package:restaurantour/domain/restaurants/service_contract/restaurants_service_contract.dart';
import 'package:restaurantour/presentation/app/state_management/state_management.dart';
import 'package:restaurantour/domain/core/result/result.dart';

@injectable
class HomeCubit extends PaginationCubit<RestaurantEntity> {
  HomeCubit(
    RestaurantsServiceContract restaurantsService,
  ) : super(
          fetchItemCallBack: ({
            itemsPerPage,
            sort,
            required page,
            filters = const {},
          }) async {
            final restaurantsResult = await restaurantsService.getRestaurants(
              itemsPerPage: itemsPerPage,
              page: page,
            );
            return restaurantsResult.when(
              error: (failure) => throw failure,
              success: (restaurants) {
                return restaurants;
              },
            );
          },
          pagingController: PagingController(
            firstPageKey: 0,
          ),
        );
}
