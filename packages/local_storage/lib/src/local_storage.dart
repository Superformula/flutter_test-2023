import 'dart:async';

import 'package:local_storage/objectbox.g.dart';
import 'package:local_storage/src/dao/restaurant_dao.dart';
import 'package:local_storage/src/models/restaurant.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:domain_models/domain_models.dart' as domain;

class LocalStorage {
  late final Store _store;
  late final RestaurantDao _restaurantDao;

  LocalStorage._create(this._store) {
    _restaurantDao = RestaurantDao(store: _store);
  }

  static Future<LocalStorage> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(docsDir.path, "local-storage"),
    );
    return LocalStorage._create(store);
  }

  Stream<List<domain.Restaurant>> get restaurantListener =>
      _restaurantDao.restaurantListener.map(
        (restaurants) => restaurants.map((e) => e.toDomainModel()).toList(),
      );

  int addRestaurant(domain.Restaurant restaurant) =>
      _restaurantDao.addRestaurant(Restaurant.fromDomainModel(restaurant));

  bool removeRestaurant(String id) => _restaurantDao.removeRestaurant(id);

  Stream<bool> containsRestaurantListener(String id) =>
      _restaurantDao.constainsRestaurantListener(id);
}
