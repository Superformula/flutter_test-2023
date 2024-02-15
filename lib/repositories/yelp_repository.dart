import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/models/restaurant.dart';

const _apiKey =
    'zdiwGUIV61NgdbWT-kCTA3VrkSxhHefvqX7JkfA_7QrtplqQlsHOoNVGcZGEdEjU5Q4ehGtbZt3nh_6fzAei1bFWjn6vW_HQirTRtKqvla1jG5hCwmbY-cb0GADNZXYx';

class YelpRepository {
  late Dio dio;

  YelpRepository({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.yelp.com',
                headers: {
                  'Authorization': 'Bearer $_apiKey',
                  'Content-Type': 'application/graphql',
                },
              ),
            );

  var data = {
    "data": {
      "search": {
        "total": 5056,
        "business": [
          {
            "id": "faPVqws-x-5k2CQKDNtHxw",
            "name": "Yardbird Southern Table & Bar",
            "price": "120.00",
            "rating": 4.5,
            "location": {
              "formatted_address": '102 Lakeside Ave Seattle, WA 98122',
            },
            "photos": [
              "https://i.pravatar.cc",
              "https://i.pravatar.cc",
            ],
            "categories": [
              {"alias": "Italian", "title": "Italian"},
            ],
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
            "id": "faPVqws-x-5k2CQKDNtHxf",
            "name": "Yardbird Southern Table & Bar",
            "price": "120.00",
            "rating": 4.5,
            "photos": [
              "https://i.pravatar.cc",
              "https://i.pravatar.cc",
            ],
            "categories": [
              {"alias": "Italian", "title": "Italian"},
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
            "id": "faPVqws-x-5k2CQKDNtHxg",
            "name": "Yardbird Southern Table & Bar",
            "price": "120.00",
            "rating": 4.5,
            "photos": [
              "https://i.pravatar.cc",
              "https://i.pravatar.cc",
            ],
            "categories": [
              {"alias": "Italian", "title": "Italian"},
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
            "id": "faPVqws-x-5k2CQKDNtHxh",
            "name": "Yardbird Southern Table & Bar",
            "price": "120.00",
            "rating": 4.5,
            "photos": [
              "https://i.pravatar.cc",
              "https://i.pravatar.cc",
            ],
            "categories": [
              {"alias": "Italian", "title": "Italian"},
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

  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      //I REACHED THE LIMIT. 🥲. SORRY.

      // final response = await dio.post<Map<String, dynamic>>(
      //   '/v3/graphql',
      //   data: _getQuery(offset),
      // );
      // //return RestaurantQueryResult.fromJson(response.data!['data']['search']);
      return RestaurantQueryResult.fromJson(
        data['data']!['search'] as Map<String, dynamic>,
      );
    } catch (e) {
      return null;
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
