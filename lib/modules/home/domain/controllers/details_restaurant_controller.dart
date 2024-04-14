import 'package:mobx/mobx.dart';
import 'package:restaurantour/modules/home/domain/repositories/restaurant_repository_interface.dart';

import '../../../../core/enums/status_type_enum.dart';
import '../../data/models/restaurant.dart';

part 'details_restaurant_controller.g.dart';

class DetailsRestaurantController = DetailsRestaurantControllerBase with _$DetailsRestaurantController;

abstract class DetailsRestaurantControllerBase with Store {
  final IRestaurantRepository _restaurantRepository;
  DetailsRestaurantControllerBase(this._restaurantRepository);

  // * Variables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls list of restaurants
  late Restaurant restaurant;

  // * Observables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls status of page
  @observable
  StatusType status = StatusType.idle;

  // * Actions
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Setup initial
  Future<void> loadRestaurant(Restaurant restaurantModel) {
    restaurant = restaurantModel;
    return _getInfosRestaurant();
  }

  /// Gets all restaurants
  Future<void> _getInfosRestaurant() async {
    status = StatusType.loading;

    if (restaurant.id == null) {
      status = StatusType.failure;
      return;
    }

    final result = await _restaurantRepository.getRestaurantById(id: restaurant.id!);

    if (result.isSuccess) {
      restaurant = result.data!;
      status = StatusType.success;
    } else {
      status = StatusType.failure;
    }
  }
}
