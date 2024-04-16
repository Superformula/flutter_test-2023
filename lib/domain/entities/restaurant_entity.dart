import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'restaurant_entity.g.dart';

@JsonSerializable()
class CategoryEntity extends Equatable {
  final String? alias;
  final String? title;

  const CategoryEntity({
    this.alias,
    this.title,
  });

  @override
  List<Object?> get props => [alias, title];

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}

@JsonSerializable()
class HoursEntity extends Equatable {
  final bool? isOpenNow;

  const HoursEntity({
    this.isOpenNow,
  });

  @override
  List<Object?> get props => [isOpenNow];

  factory HoursEntity.fromJson(Map<String, dynamic> json) =>
      _$HoursEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HoursEntityToJson(this);
}

@JsonSerializable()
class UserEntity extends Equatable {
  final String? id;
  final String? imageUrl;
  final String? name;

  const UserEntity({this.id, this.imageUrl, this.name});

  @override
  List<Object?> get props => [id, imageUrl, name];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

@JsonSerializable()
class ReviewEntity extends Equatable {
  final String? id;
  final int? rating;
  final UserEntity? user;

  const ReviewEntity({
    this.id,
    this.rating,
    this.user,
  });

  @override
  List<Object?> get props => [id, rating, user];

  factory ReviewEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewEntityToJson(this);
}

@JsonSerializable()
class LocationEntity extends Equatable {
  final String? formattedAddress;

  const LocationEntity({
    this.formattedAddress,
  });

  @override
  List<Object?> get props => [formattedAddress];

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      _$LocationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LocationEntityToJson(this);
}

@JsonSerializable()
class RestaurantEntity extends Equatable {
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<CategoryEntity>? categories;
  final List<HoursEntity>? hours;
  final List<ReviewEntity>? reviews;
  final LocationEntity? location;

  const RestaurantEntity({
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

  @override
  List<Object?> get props {
    return [
      id,
      name,
      price,
      rating,
      photos,
      categories,
      hours,
      reviews,
      location,
    ];
  }

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) =>
      _$RestaurantEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantEntityToJson(this);

  /// Use the first category for the category shown to the userModel
  String get displayCategory {
    if (categories != null && categories!.isNotEmpty) {
      return categories!.first.title ?? '';
    }
    return '';
  }

  /// Use the first image as the image shown to the userModel
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
class RestaurantQueryResultEntity extends Equatable {
  final int? total;
  final List<RestaurantEntity>? restaurants;

  const RestaurantQueryResultEntity({
    this.total,
    this.restaurants,
  });

  @override
  List<Object?> get props => [total, restaurants];

  factory RestaurantQueryResultEntity.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultEntityToJson(this);
}
