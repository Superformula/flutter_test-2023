class Urls {
  static const String baseUrl = 'https://api.yelp.com';
  static const String apiKey = 'jqqiz9wXomxYboRgZ_GgiwlHcN_CJAQagyAKYryrldzoID6iwSV3FG5Jsonu8KB_2BF-BM0k1QFPhv0vyMJuDG_NeNp3B2tYIT6kEVRriy3EiHJhBq5XgjDPVWLRZXYx';
  static String bearerToken = 'Bearer $apiKey'; 

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