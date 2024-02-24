import 'package:restaurants_repository/src/models/models.dart';

/// {@template restaurants_repository_contract}
/// Interface for an API providing access to Restaurants data
/// {@endtemplate}
abstract class RestaurantsRepositoryContract {
  /// {@macro restaurants_repository_contract}
  const RestaurantsRepositoryContract();

  /// Provides a list of [Restaurant].
  Future<List<Restaurant>> getRestaurants({
    required String tabId,
    int? page,
    int? itemsPerPage,
  });
}
