class RTQueries {
  static String getRestaurantsQuery(int offset) {
    return '''
query restaurantsQuery {
  search(location: "Las Vegas", limit: 20, offset: $offset) {
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
    total
  }
}
''';
  }

  static String getReviewsQuery({required String restaurantId, required int offset}) {
    return '''
query reviewsQuery {
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
query restaurantDetailsQuery {
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

  static String getTotalReviewForRestaurantQuery({required String restaurantId}) {
    return '''
query totalReviewForRestaurantQuery {
  reviews(business: "$restaurantId") {
    total
  }
}
''';
  }
}
