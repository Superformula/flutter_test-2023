import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Category {
  final String? alias;
  final String? title;

  Category({
    this.alias,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  factory Category.fixture() => Category(alias: 'newamerican', title: 'New American');

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Hours {
  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  const Hours({this.isOpenNow});

  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);
  factory Hours.fixture() => const Hours(isOpenNow: true);

  Map<String, dynamic> toJson() => _$HoursToJson(this);
}

@JsonSerializable()
class User {
  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  const User({this.id, this.imageUrl, this.name});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.fixture() => const User(
        id: 'userId',
        name: 'George M.',
        imageUrl: 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/400.jpg',
      );

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Review {
  static const _review = 'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.';

  final String? id;
  final int? rating;
  final String? review;
  final User? user;

  const Review({this.review = _review, this.id, this.rating, this.user});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  factory Review.fixture() => Review(
        id: 'reviewId',
        rating: 3,
        review: 'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.',
        user: User.fixture(),
      );

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  Location({this.formattedAddress});

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  factory Location.fixture() => Location(formattedAddress: 'address');

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
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

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  factory Restaurant.fixture() => Restaurant(
        id: 'restaurantId',
        name: 'Restaurant Name',
        price: '\$\$',
        rating: 3.5,
        photos: ['http://placeimg.com/640/480/business'],
        categories: [Category.fixture()],
        hours: [Hours.fixture()],
        reviews: [Review.fixture()],
        location: Location.fixture(),
      );

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

  const RestaurantQueryResult({this.total, this.restaurants});

  factory RestaurantQueryResult.fromJson(Map<String, dynamic> json) => _$RestaurantQueryResultFromJson(json);
  factory RestaurantQueryResult.fixture() => RestaurantQueryResult(restaurants: [Restaurant.fixture()]);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultToJson(this);
}
