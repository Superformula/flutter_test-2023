import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  const Restaurant({
    this.id,
    this.name,
    this.rating,
    this.price,
    this.photoUrl,
    this.category,
    this.isOpenNow,
    this.reviews,
    this.address,
  });
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final String? photoUrl;
  final String? category;
  final bool? isOpenNow;
  final List<Review>? reviews;
  final String? address;

  static const empty = Restaurant();
  @override
  List<Object?> get props => [
        id,
        name,
        price,
        rating,
        photoUrl,
        category,
        isOpenNow,
        reviews,
        address,
      ];
}

class Review extends Equatable {
  const Review({this.id, this.rating, this.user, this.text});
  final String? id;
  final int? rating;
  final User? user;
  final String? text;

  @override
  List<Object?> get props => [id, rating, user, text];
}

class User extends Equatable {
  final String? id;
  final String? imageUrl;
  final String? name;

  const User({
    this.id,
    this.imageUrl,
    this.name,
  });

  @override
  List<Object?> get props => [id, imageUrl, name];
}
