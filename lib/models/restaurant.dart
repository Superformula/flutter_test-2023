import 'package:json_annotation/json_annotation.dart';
import "package:flutter/foundation.dart";

part 'restaurant.g.dart';

@JsonSerializable()
class Category {
  final String? alias;
  final String? title;

  const Category({
    this.alias,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String toString() {
    return 'Category{alias: $alias, title: $title}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          alias == other.alias &&
          title == other.title;

  @override
  int get hashCode => alias.hashCode ^ title.hashCode;
}

@JsonSerializable()
class Hours {
  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  const Hours({
    this.isOpenNow,
  });

  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);

  Map<String, dynamic> toJson() => _$HoursToJson(this);

  @override
  String toString() => 'Hours{isOpenNow: $isOpenNow}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hours &&
          runtimeType == other.runtimeType &&
          isOpenNow == other.isOpenNow;

  @override
  int get hashCode => isOpenNow.hashCode;
}

@JsonSerializable()
class User {
  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  const User({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ imageUrl.hashCode ^ name.hashCode;
}

@JsonSerializable(explicitToJson: true)
class Review {
  final String? id;
  final int? rating;
  final String? text;
  final User? user;

  const Review({
    this.id,
    this.rating,
    this.text,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  String toString() {
    return 'Review{id: $id, rating: $rating, text: $text, user: $user}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Review &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rating == other.rating &&
          text == other.text &&
          user == other.user;

  @override
  int get hashCode =>
      id.hashCode ^ rating.hashCode ^ text.hashCode ^ user.hashCode;
}

@JsonSerializable()
class Location {
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  const Location({
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    return 'Location{formattedAddress: $formattedAddress}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          formattedAddress == other.formattedAddress;

  @override
  int get hashCode => formattedAddress.hashCode;
}

@JsonSerializable(explicitToJson: true)
class Restaurant {
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<Category>? categories;
  final List<Hours>? hours;
  final List<Review>? reviews;
  final Location? location;

  const Restaurant({
    this.id,
    this.name,
    this.price,
    this.rating,
    this.photos,
    this.categories,
    this.hours,
    this.reviews,
    this.location,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  /// Use the first category for the category shown to the user
  String get displayCategory {
    if (categories != null && categories!.isNotEmpty) {
      return categories!.first.title ?? '';
    }
    return '';
  }

  /// Use the first image as the image shown to the user
  String get heroImage {
    if (photos != null && photos!.isNotEmpty) {
      return photos!.first;
    }
    return '';
  }

  /// This logic is probably not correct in all cases but it is ok
  /// for this application
  bool get isOpen {
    if (hours != null && hours!.isNotEmpty) {
      return hours!.first.isOpenNow ?? false;
    }
    return false;
  }

  Restaurant copyWith({
    String? id,
    String? name,
    String? price,
    double? rating,
    List<String>? photos,
    List<Category>? categories,
    List<Hours>? hours,
    List<Review>? reviews,
    Location? location,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      photos: photos ?? this.photos,
      categories: categories ?? this.categories,
      hours: hours ?? this.hours,
      reviews: reviews ?? this.reviews,
      location: location ?? this.location,
    );
  }

  @override
  String toString() {
    return 'Restaurant{id: $id,\n'
        'name: $name,\n'
        'price: $price,\n'
        'rating: $rating,\n'
        'photos: $photos,\n'
        'categories: $categories,\n'
        'hours: $hours,\n'
        'reviews: $reviews,\n'
        'location: $location}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Restaurant &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          rating == other.rating &&
          listEquals(photos, other.photos) &&
          listEquals(categories, other.categories) &&
          listEquals(hours, other.hours) &&
          listEquals(reviews, other.reviews) &&
          location == other.location;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      rating.hashCode ^
      photos.hashCode ^
      categories.hashCode ^
      hours.hashCode ^
      reviews.hashCode ^
      location.hashCode;
}

@JsonSerializable()
class RestaurantQueryResult {
  final int? total;
  @JsonKey(name: 'business')
  final List<Restaurant>? restaurants;

  const RestaurantQueryResult({
    this.total,
    this.restaurants,
  });

  factory RestaurantQueryResult.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultToJson(this);
}
