class RTQueries {
  static String getRestaurantsQuery(int offset) {
    return '''
query getRestaurants {
  search(location: "Las Vegas", limit: 20, offset: 0) {
    business {
      id
      name
      price
      rating
      photos
      categories {
        title
        alias
      }
      hours {
        is_open_now
      }
    }
  }
}

''';
  }

  static String getReviewsQuery({required String restaurantId, required int offset}) {
    return '''
query MyQuery {
    reviews(business: "$restaurantId", limit: 10, offset: $offset) {
    total
    review {
      text
      rating
      user {
        id
        name
        image_url
      }
    }
  }
}
''';
  }

  static String getRestaurantDetailsQuery({required String restaurantId}) {
    return '''
query MyQuery {
  business(id: "$restaurantId") {
    alias
    categories {
      alias
      title
    }
    hours {
      is_open_now
    }
    location {
      formatted_address
    }
    rating
    id
    photos
    name
    price
  }
}
''';
  }
}
