import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/user_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/review_entity.dart';

class ReviewModel {
  final ReviewEntity reviewEntity;

  const ReviewModel(this.reviewEntity);

  Map<String, dynamic> toJson() {
    final (id, rating, text, user) = reviewEntity;
    return {
      'id': id,
      'rating': rating,
      'text': text,
      'user': user.toJson(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      (
        json['id'] as String,
        json['rating'] as int,
        json['text'] as String,
        UserModel.fromJson(
          json['user'] as Map<String, dynamic>,
        ),
      ),
    );
  }
}
