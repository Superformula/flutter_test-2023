import 'package:mockito/mockito.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class MockYelpRepository extends Mock implements YelpRepository {
  @override
  var data = {
    "data": {
      "search": {
        "total": 5056,
        "business": [
          {
            "id": "faPVqws-x-5k2CQKDNtHxw",
            "name": "Yardbird Southern Table & Bar",
            "price": "\$\$",
            "rating": 4.5,
            "photos": [
              "https://i.pravatar.cc",
            ],
            "location": {
              "formatted_address": '102 Lakeside Ave Seattle, WA 98122',
            },
            "reviews": [
              {
                "id": "sjZoO8wcK1NeGJFDk5i82Q",
                "rating": 5,
                "user": {
                  "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Gina T.",
                },
              },
              {
                "id": "okpO9hfpxQXssbTZTKq9hA",
                "rating": 5,
                "user": {
                  "id": "0x9xu_b0Ct_6hG6jaxpztw",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Crystal L.",
                },
              }
            ],
          },
          {
            "id": "faPVqws-x-5k2CQKDNtHxw",
            "name": "Yardbird Southern Table & Bar",
            "price": "\$\$",
            "rating": 4.5,
            "photos": [
              "https://i.pravatar.cc",
            ],
            "location": {
              "formatted_address": '102 Lakeside Ave\nSeattle, WA 98122',
            },
            "reviews": [
              {
                "id": "sjZoO8wcK1NeGJFDk5i82Q",
                "rating": 5,
                "user": {
                  "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Gina T.",
                },
              },
              {
                "id": "okpO9hfpxQXssbTZTKq9hA",
                "rating": 5,
                "user": {
                  "id": "0x9xu_b0Ct_6hG6jaxpztw",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Crystal L.",
                },
              }
            ],
          },
          {
            "id": "faPVqws-x-5k2CQKDNtHxw",
            "name": "Yardbird Southern Table & Bar",
            "price": "\$\$",
            "rating": 4.5,
            "photos": [
              "https://i.pravatar.cc",
            ],
            "location": {
              "formatted_address": '102 Lakeside Ave\nSeattle, WA 98122',
            },
            "reviews": [
              {
                "id": "sjZoO8wcK1NeGJFDk5i82Q",
                "rating": 5,
                "user": {
                  "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Gina T.",
                },
              },
              {
                "id": "okpO9hfpxQXssbTZTKq9hA",
                "rating": 5,
                "user": {
                  "id": "0x9xu_b0Ct_6hG6jaxpztw",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Crystal L.",
                },
              }
            ],
          },
          {
            "id": "faPVqws-x-5k2CQKDNtHxw",
            "name": "Yardbird Southern Table & Bar",
            "price": "\$\$",
            "rating": 4.5,
            "photos": [
              "https://i.pravatar.cc",
            ],
            "location": {
              "formatted_address": '102 Lakeside Ave\nSeattle, WA 98122',
            },
            "reviews": [
              {
                "id": "sjZoO8wcK1NeGJFDk5i82Q",
                "rating": 5,
                "user": {
                  "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Gina T.",
                },
              },
              {
                "id": "okpO9hfpxQXssbTZTKq9hA",
                "rating": 5,
                "user": {
                  "id": "0x9xu_b0Ct_6hG6jaxpztw",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Crystal L.",
                },
              }
            ],
          }
        ],
      },
    },
  };

  @override
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      return RestaurantQueryResult.fromJson(
        data['data']!['search'] as Map<String, dynamic>,
      );
    } catch (e) {
      return null;
    }
  }
}
