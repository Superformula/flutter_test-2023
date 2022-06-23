import 'package:mockito/mockito.dart';
import 'package:restaurantour/features/restauran_tour/model/restauran_service.dart';
import 'package:restaurantour/features/restauran_tour/model/restaurant.dart';
import 'package:restaurantour/repositories/api_status.dart';

class MockRestauranService extends Mock implements RestauranService {
  @override
  Future<Object> getAllRestaurans({int offSet = 0}) async {
    RestaurantQueryResult response = RestaurantQueryResult(
      total: 10,
      restaurants: [
        Restaurant(
          id: "2321",
          name: "Lol",
          price: "24.5\$",
          photos: [""],
          categories: [Category(alias: "", title: "")],
          hours: [const Hours(isOpenNow: true)],
        ),
        Restaurant(
          id: "4321",
          name: "Smile",
          price: "44.5\$",
          photos: [""],
          categories: [Category(alias: "", title: "")],
          hours: [const Hours(isOpenNow: false)],
        )
      ],
    );
    return Success<RestaurantQueryResult>(
      response: response,
    );
  }
}
