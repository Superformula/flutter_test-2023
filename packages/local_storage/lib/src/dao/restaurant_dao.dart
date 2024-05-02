import 'package:local_storage/objectbox.g.dart';
import 'package:local_storage/src/models/restaurant.dart';

class RestaurantDao {
  final Store _store;

  RestaurantDao({required Store store}) : _store = store;

  int addRestaurant(Restaurant restaurant) =>
      _store.box<Restaurant>().put(restaurant);

  bool removeRestaurant(String id) {
    final restaurant = _store
        .box<Restaurant>()
        .query(Restaurant_.id.equals(id))
        .build()
        .findFirst();
    if (restaurant != null) {
      return _store.box<Restaurant>().remove(restaurant.primaryKey);
    }
    return false;
  }

  Stream<List<Restaurant>> get restaurantListener => _store
      .box<Restaurant>()
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());
  
  Stream<bool> constainsRestaurantListener(String id) => _store
      .box<Restaurant>()
      .query(Restaurant_.id.equals(id))
      .watch(triggerImmediately: true)
      .map((query) => query.find().isNotEmpty);

}
