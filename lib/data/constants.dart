class Urls {
  static const String baseUrl = 'https://api.yelp.com';
  static const String apiKey =
      'Gm26vvRM976dw2sRd80m7T-j3C-u-nN6kBaJ6xHHwLMwfEtVp_SBPW03e591peSBIhuVeXrZpaQ8E2MDTjnA690HfjXQUBy_A6LEI4eUTli3Eum6_AjHgbG6-_r-ZXYx';
  static const String ghrapQLRoute = '/v3/graphql';
  static String getRestaurantsByCity({
    required String city,
    required int limit,
    required int offset,
  }) =>
      '''
query getRestaurants {
  search(location: "$city", limit: $limit, offset: $offset) {
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
