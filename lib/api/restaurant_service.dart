import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class RestaurantService {
  static Future<dynamic> getRestaurants() async {
    try {
      var response = await YelpRepository().getRestaurants();
      if (200 == response.statusCode) {
        return Success(
          response: RestaurantQueryResult.fromJson(
                response.data['data']['search'],
              ).restaurants ??
              [],
        );
      } else {
        return Failure(
          code: response.statusCode,
          response: errorMessage(response.statusCode!),
        );
      }
    } catch (e) {
      return Failure(
          code: APIError.INTERNAL_SERVER_ERROR, response: "Unknown Error");
    }
  }

  static String errorMessage(int code) {
    switch (code) {
      case APIError.FIELD_REQUIRED:
        return "The data could not be read. Please contact the company.";
      case APIError.UNAUTHORIZED:
        return "Please authenticate to use the app.";
      case APIError.INTERNAL_SERVER_ERROR:
        return "Unable to read current data. We apologize for any inconvenience. Please try again later.";
      default:
        return "There is unknown error. please close app and reopen.";
    }
  }
}
