import 'package:restaurantour/models/restaurant.dart';

//Get overall rating for a restaurant / based on reviews
class RatingCalculator {
  static double calculateAverageRating(List<Review> reviews) {
    if (reviews.isNotEmpty) {
      double average = reviews
              .map((review) => review.rating?.toDouble() ?? 0.0)
              .reduce((a, b) => a + b) /
          reviews.length;

      return double.parse(average.toStringAsFixed(2));
    }
    return 0.0; // Return 0 if there are no reviews or reviews are null
  }
}
