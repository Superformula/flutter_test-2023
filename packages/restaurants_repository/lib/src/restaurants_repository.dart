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
    required String tabId,
    int? page,
    int? itemsPerPage,
  }) async {
    final response = await apiClient.get<dynamic>(
      '/v3/graphql',
      body: Queries.getRestaurants(),
    );
    late final RestaurantQueryResult result;
    try {
      result =
          RestaurantQueryResult.fromJson(response! as Map<String, dynamic>);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(DeserializationException(error), stackTrace);
    }

    return result.restaurants ?? [];
    // // return RestaurantQueryResult.fromJson(response.data!['data']['search']);

    // final isPaginated = page != null;
    // try {
    //   final homeResponse = await _fetchHomeResponse(
    //     tabId: tabId,
    //     page: page,
    //     itemsPerPage: itemsPerPage,
    //   );

    //   if (isPaginated) {
    //     final results = homeResponse.payload.results as List;
    //     final contentSections = _deserializeContentSections(results);

    //     return HomeResults(
    //       contentSections: contentSections,
    //     );
    //   } else {
    //     final results = homeResponse.payload.results as Map<String, dynamic>;
    //     return HomeResults.fromJson(results);
    //   }
    // } catch (exception, stackTrace) {
    //   throw HomeRepositoryError.unknown(
    //     exception: exception,
    //     stackTrace: stackTrace,
    //   );
    // }
  }
}
