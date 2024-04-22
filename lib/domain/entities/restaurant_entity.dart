import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<ReviewEntity>? reviews;
  final List<CategoriesEntity>? categories;
  final List<HoursEntity>? hours;
  final LocationEntity? location;

  const RestaurantEntity({
    this.id,
    this.name,
    this.price,
    this.rating,
    this.photos,
    this.reviews,
    this.categories,
    this.hours,
    this.location,
  });

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

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        rating,
        photos,
        reviews,
        categories,
        hours,
        location,
      ];
}

class CategoriesEntity extends Equatable {
  final String? title;
  final String? alias;

  const CategoriesEntity({
    this.title,
    this.alias,
  });

  @override
  List<Object?> get props => [title, alias];
}

class HoursEntity extends Equatable {
  final bool? isOpenNow;

  const HoursEntity({
    this.isOpenNow,
  });

  @override
  List<Object?> get props => [isOpenNow];
}

class LocationEntity extends Equatable {
  final String? formattedAddress;

  const LocationEntity({
    this.formattedAddress,
  });

  @override
  List<Object?> get props => [formattedAddress];
}

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
}

class UserEntity extends Equatable {
  final String? id;
  final String? imageUrl;
  final String? name;

  const UserEntity({
    this.id,
    this.imageUrl,
    this.name,
  });

  @override
  List<Object?> get props => [id, imageUrl, name];
}

class RestaurantQueryResultEntity extends Equatable {
  final int? total;
  final List<RestaurantEntity>? restaurants;

  const RestaurantQueryResultEntity({
    this.total,
    this.restaurants,
  });

  @override
  List<Object?> get props => [total, restaurants];
}
