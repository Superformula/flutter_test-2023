// ignore_for_file: avoid_dynamic_calls

import 'package:api_client/api_client.dart';
import 'package:restaurants_repository/src/constants/queries.dart';
import 'package:restaurants_repository/src/contract/contract.dart';
import 'package:restaurants_repository/src/models/models.dart';

/// {@template restaurants_repository}
/// Package to manage the Restaurants domain
/// {@endtemplate}
class RestaurantsRepository implements RestaurantsRepositoryContract {
  /// {@macro restaurants_repository}
  RestaurantsRepository.fromRestApiService({
    required this.apiClient,
  });

  /// Api client to be used for doing the requests.
  final ApiClient apiClient;

  /// [getRestaurants] whitout pagination and with pagination when `page` is
  /// not null.
  @override
  Future<List<Restaurant>> getRestaurants({
    int? page,
    int? itemsPerPage,
  }) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      'v3/graphql',
      body: Queries.getRestaurants(
        page: page ?? 0,
        itemsPerPage: itemsPerPage ?? 50,
      ),
    );
    late final RestaurantQueryResult result;
    try {
      result = RestaurantQueryResult.fromJson(
        response!['data']['search'] as Map<String, dynamic>,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(DeserializationException(error), stackTrace);
    }

    return result.restaurants ?? [];
  }
}
