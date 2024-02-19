class Urls {
  static const String baseUrl = 'https://api.yelp.com';
  static const String apiKey = '';
  static String bearerToken = 'Bearer $apiKey'; 
  static String getDetailsUr(String id) => '$baseUrl/v3/businesses/$id';
  static String getReviewsUr(String id) => '$baseUrl/v3/businesses/$id/reviews?limit=20&sort_by=yelp_sort';


  static String getQuery({int offset = 0}) => ''
  '''
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