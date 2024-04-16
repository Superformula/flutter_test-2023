import 'package:json_annotation/json_annotation.dart';
import 'package:restaurantour/domain/entities/entities.dart';
part 'restaurant_model.g.dart';

@JsonSerializable()
class CategoryModel extends CategoryEntity {
  final String? aliasModel;
  final String? titleModel;

  const CategoryModel({
    super.alias,
    super.title,
    this.aliasModel,
    this.titleModel,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class HoursModel extends HoursEntity {
  @JsonKey(name: 'is_open_now')
  final bool? isOpenNowModel;

  const HoursModel({
    this.isOpenNowModel,
  });

  factory HoursModel.fromJson(Map<String, dynamic> json) =>
      _$HoursModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HoursModelToJson(this);
}

@JsonSerializable()
class UserModel extends UserEntity {
  final String? idModel;
  @JsonKey(name: 'image_url')
  final String? imageUrlModel;
  final String? nameModel;

  const UserModel({
    super.id,
    super.imageUrl,
    super.name,
    this.idModel,
    this.imageUrlModel,
    this.nameModel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class ReviewModel extends ReviewEntity {
  final String? idModel;
  final int? ratingModel;
  final UserModel? userModel;

  const ReviewModel({
    super.id,
    super.rating,
    super.user,
    this.idModel,
    this.ratingModel,
    this.userModel,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class LocationModel extends LocationEntity {
  @JsonKey(name: 'formatted_address')
  final String? formattedAddressModel;

  const LocationModel({
    super.formattedAddress,
    this.formattedAddressModel,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

@JsonSerializable()
class RestaurantModel extends RestaurantEntity {
  final String? idModel;
  final String? nameModel;
  final String? priceModel;
  final double? ratingModel;
  final List<String>? photosModel;
  final List<CategoryModel>? categoriesModel;
  final List<HoursModel>? hoursModel;
  final List<ReviewModel>? reviewsModel;
  final LocationModel? locationModel;

  const RestaurantModel({
    super.id,
    super.name,
    super.price,
    super.rating,
    super.photos,
    super.categories,
    super.hours,
    super.reviews,
    super.location,
    this.idModel,
    this.nameModel,
    this.priceModel,
    this.ratingModel,
    this.photosModel,
    this.categoriesModel,
    this.hoursModel,
    this.reviewsModel,
    this.locationModel,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}

@JsonSerializable()
class RestaurantQueryResultModel extends RestaurantQueryResultEntity {
  final int? totalModel;
  @JsonKey(name: 'business')
  final List<RestaurantModel>? restaurantsModel;

  const RestaurantQueryResultModel({
    super.total,
    super.restaurants,
    this.totalModel,
    this.restaurantsModel,
  });

  factory RestaurantQueryResultModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RestaurantQueryResultModelToJson(this);
}
