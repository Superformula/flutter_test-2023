import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/presentation/app/state_management/state_management.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

@injectable
class HomeCubit extends PaginationCubit<Restaurant> {
  HomeCubit(
    RestaurantsRepositoryContract restaurantsRepository,
  ) : super(
          fetchItemCallBack: ({
            itemsPerPage,
            sort,
            required page,
            filters = const {},
          }) async {
            return restaurantsRepository.getRestaurants(
              itemsPerPage: itemsPerPage,
              page: page,
            );
          },
          pagingController: PagingController(
            firstPageKey: 0,
          ),
        );
}
