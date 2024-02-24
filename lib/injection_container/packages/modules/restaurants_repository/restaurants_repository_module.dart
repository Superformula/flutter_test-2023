import 'package:api_client/api_client.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurants_repository/restaurants_repository.dart';

/// Restaurants Repository Module configuration using [Injectable] package
@module
abstract class RestaurantsRepositoryModule {
  @singleton
  RestaurantsRepositoryContract restaurantsRepository(
          ApiClient restApiService) =>
      RestaurantsRepository.fromRestApiService(
        apiClient: restApiService,
      );
}
