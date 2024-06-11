import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/core/hive/hive_type_id.dart';

part 'restaurant.g.dart';

@JsonSerializable()
@HiveType(typeId: categoryTypeId)
class Category {
  @HiveField(0)
  final String? alias;
  @HiveField(1)
  final String? title;

  Category({
    this.alias,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
@HiveType(typeId: hoursTypeId)
class Hours {
  @JsonKey(name: 'is_open_now')
  @HiveField(0)
  final bool? isOpenNow;

  const Hours({
    this.isOpenNow,
  });

  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);

  Map<String, dynamic> toJson() => _$HoursToJson(this);
}

@JsonSerializable()
@HiveType(typeId: userTypeId)
class User {
  @HiveField(0)
  final String? id;
  @JsonKey(name: 'image_url')
  @HiveField(1)
  final String? imageUrl;
  @HiveField(2)
  final String? name;

  const User({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
@HiveType(typeId: reviewTypeId)
class Review {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final int? rating;
  @HiveField(2)
  final User? user;

  const Review({
    this.id,
    this.rating,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 5)
class Location {
  @JsonKey(name: 'formatted_address')
  @HiveField(0)
  final String? formattedAddress;

  Location({
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: restaurantTypeId)
class Restaurant {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? price;
  @HiveField(3)
  final double? rating;
  @HiveField(4)
  final List<String>? photos;
  @HiveField(5)
  final List<Category>? categories;
  @HiveField(6)
  final List<Hours>? hours;
  @HiveField(7)
  final List<Review>? reviews;
  @HiveField(8)
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
