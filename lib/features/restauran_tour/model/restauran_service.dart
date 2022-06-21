import 'package:flutter/foundation.dart';
import 'package:restaurantour/features/restauran_tour/model/restaurant.dart';
import 'package:restaurantour/repositories/api_status.dart';
import 'package:restaurantour/repositories/endpoints.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class RestauranService {
  late YelpRepository yelpRepo;

  RestauranService({
    @visibleForTesting YelpRepository? yelpRepo,
  }) : yelpRepo = yelpRepo ?? YelpRepository();

  Future<Object> getAllRestaurans({int offSet = 0}) async {
    try {
      var response = await yelpRepo.getResponse(
        path: restauranUrl,
        query: _getQuery(offSet),
      );
      if (200 == response.statusCode) {
        return Success<RestaurantQueryResult>(
          response:
              RestaurantQueryResult.fromJson(response.data['data']['search']),
        );
      }
      return Failure(
        code: response.statusCode ?? UNKNOWN_ERROR,
        errorResponse: "INVALID RESPONSE",
      );
    } catch (e) {
      return Failure(code: NO_INTERNET, errorResponse: "NO INTERNET");
    }
  }

  String _getQuery(int offset) {
    return '''
query getRestaurants {
  search(location: "Las Vegas", limit: 20, offset: $offset) {
    total    
    business {
      id
      name
      price
      rating
      photos
      reviews {
        id
        rating
        user {
          id
          image_url
          name
        }
      }
      categories {
        title
        alias
      }
      hours {
        is_open_now
      }
      location {
        formatted_address
      }
    }
  }
}
''';
  }
}
