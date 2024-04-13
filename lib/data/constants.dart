class Urls {
  static const String baseUrl = 'https://api.yelp.com';
  static const String apiKey =
      'wfYIpeyetAPJbQYg5ITUE4wxzqCvoEQM5FQyW9Xq4SGJG52vkefWY_Irq9yg_TKpXRYJUgTO48W_fVXReEABY919sT74bHoCAyNH4b0kTe94rmEWFWNo1GjFxUXjZXYx';
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
        text
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
