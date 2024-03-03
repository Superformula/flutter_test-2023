import 'package:restaurantour/domain/restaurants/entities/user_entity.dart';

class ReviewEntity {
  final String id;
  final String userId;
  final String comment;
  final int rating;
  final UserEntity author;

  ReviewEntity({
    required this.id,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.author,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewEntity &&
        other.id == id &&
        other.userId == userId &&
        other.comment == comment &&
        other.rating == rating &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        comment.hashCode ^
        rating.hashCode ^
        author.hashCode;
  }
}
