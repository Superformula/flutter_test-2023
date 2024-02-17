import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/user_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required String id,
    required int rating,
    required String text,
    required UserModel user,
  }) : super(
          id: id,
          rating: rating,
          text: text,
          user: user,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'text': text,
      'user': user.toMap(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      rating: json['rating'] ?? 0.0,
      text: json['text'] ?? '',
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
