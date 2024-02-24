/// Stores all the queries used in the restaurants_repository package.
class Queries {
  ///Returns get restaurants query.
  static String getRestaurants({int offset = 0}) => '''
query getRestaurants {
  search(location: "Las Vegas", limit: 50, offset: $offset) {
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
