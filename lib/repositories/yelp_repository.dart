import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurantour/models/restaurant.dart';

class YelpRepository {
  late Dio dio;

  YelpRepository({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.yelp.com',
                headers: {
                  'Authorization': 'Bearer ${dotenv.env['yelp_api_key']}',
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
            "name": "Restaurant Name Goes Here And Wraps 2 Lines",
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
                "reviewText":
                    "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.",
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
            "name": "Restaurant Name Goes Here And Wraps 2 Lines",
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
                "reviewText":
                    "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.",
                "user": {
                  "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Gina T.",
                },
              },
              {
                "id": "okpO9hfpxQXssbTZTKq9hA",
                "rating": 5,
                "reviewText":
                    "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.",
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
            "name": "Restaurant Name Goes Here And Wraps 2 Lines",
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
                "reviewText":
                    "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.",
                "user": {
                  "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Gina T.",
                },
              },
              {
                "id": "okpO9hfpxQXssbTZTKq9hA",
                "rating": 5,
                "reviewText":
                    "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.",
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
            "name": "Restaurant Name Goes Here And Wraps 2 Lines",
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
                "reviewText":
                    "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.",
                "user": {
                  "id": "BuBCkWFNT_O2dbSnBZvpoQ",
                  "image_url": "https://i.pravatar.cc",
                  "name": "Gina T.",
                },
              },
              {
                "id": "okpO9hfpxQXssbTZTKq9hA",
                "rating": 5,
                "reviewText":
                    "Review text goes here. Review text goes here. Review text goes here. This is a review. This is a review. This is a review that is 4 lines long.",
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
      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );
      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
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
