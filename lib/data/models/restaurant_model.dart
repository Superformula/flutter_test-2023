import 'package:equatable/equatable.dart';
import 'package:restaurantour/domain/entities/entities.dart';

class RestaurantModel extends RestaurantEntity with EquatableMixin {
  final String? idModel;
  final String? nameModel;
  final String? priceModel;
  final double? ratingModel;
  final List<String>? photosModel;
  final List<ReviewModel>? reviewsModel;
  final List<CategoriesModel>? categoriesModel;
  final List<HoursModel>? hoursModel;
  final LocationModel? locationModel;

  RestaurantModel({
    this.idModel,
    this.nameModel,
    this.priceModel,
    this.ratingModel,
    this.photosModel,
    this.reviewsModel,
    this.categoriesModel,
    this.hoursModel,
    this.locationModel,
  }) : super(
          id: idModel,
          name: nameModel,
          price: priceModel,
          rating: ratingModel,
          photos: photosModel,
          reviews: reviewsModel,
          categories: categoriesModel,
          hours: hoursModel,
          location: locationModel == null
              ? null
              : LocationEntity(
                  formattedAddress: locationModel.formattedAddressModel,
                ),
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      idModel: json["id"],
      nameModel: json["name"],
      priceModel: json["price"],
      ratingModel: json["rating"],
      photosModel: json["photos"] == null
          ? []
          : List<String>.from(json["photos"]!.map((x) => x)),
      reviewsModel: json["reviews"] == null
          ? []
          : List<ReviewModel>.from(
              json["reviews"]!.map((x) => ReviewModel.fromJson(x)),
            ),
      categoriesModel: json["categories"] == null
          ? []
          : List<CategoriesModel>.from(
              json["categories"]!.map((x) => CategoriesModel.fromJson(x)),
            ),
      hoursModel: json["hours"] == null
          ? []
          : List<HoursModel>.from(
              json["hours"]!.map((x) => HoursModel.fromJson(x)),
            ),
      locationModel: json["location"] == null
          ? null
          : LocationModel.fromJson(json["location"]),
    );
  }

  @override
  String toString() {
    return "RestaurantModel($idModel, $nameModel, $priceModel, $ratingModel, $photosModel, $reviewsModel, $categoriesModel, $hoursModel, $locationModel)";
  }

  @override
  List<Object?> get props => [
        idModel,
        nameModel,
        priceModel,
        ratingModel,
        photosModel,
        reviewsModel,
        categoriesModel,
        hoursModel,
        locationModel,
      ];
}

class CategoriesModel extends CategoriesEntity with EquatableMixin {
  const CategoriesModel({
    this.titleModel,
    this.aliasModel,
  }) : super(
          title: titleModel,
          alias: aliasModel,
        );

  final String? titleModel;
  final String? aliasModel;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      titleModel: json["title"],
      aliasModel: json["alias"],
    );
  }

  @override
  String toString() {
    return "CategoriesModel($titleModel, $aliasModel)";
  }

  @override
  List<Object?> get props => [
        titleModel,
        aliasModel,
      ];
}

class HoursModel extends HoursEntity with EquatableMixin {
  const HoursModel({
    required this.isOpenNowModel,
  }) : super(isOpenNow: isOpenNowModel);

  final bool? isOpenNowModel;

  factory HoursModel.fromJson(Map<String, dynamic> json) {
    return HoursModel(
      isOpenNowModel: json["is_open_now"],
    );
  }

  @override
  String toString() {
    return "HoursModel($isOpenNowModel)";
  }

  @override
  List<Object?> get props => [
        isOpenNowModel,
      ];
}

class LocationModel extends LocationEntity with EquatableMixin {
  const LocationModel({
    this.formattedAddressModel,
  });

  final String? formattedAddressModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    String? formattedAddress;
    if (json["formatted_address"] is String) {
      formattedAddress = json["formatted_address"];
    } else if (json["formatted_address"] is List<dynamic>) {
      formattedAddress = (json["formatted_address"] as List<dynamic>)
          .map((e) => e.toString())
          .join(', ');
    }
    return LocationModel(
      formattedAddressModel: formattedAddress,
    );
  }

  @override
  String toString() {
    return "LocationModel($formattedAddressModel)";
  }

  @override
  List<Object?> get props => [
        formattedAddressModel,
      ];
}

class ReviewModel extends ReviewEntity with EquatableMixin {
  const ReviewModel({
    this.idModel,
    this.ratingModel,
    this.userModel,
  }) : super(
          id: idModel,
          rating: ratingModel,
          user: userModel,
        );

  final String? idModel;
  final int? ratingModel;
  final UserModel? userModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      idModel: json["id"],
      ratingModel: json["rating"],
      userModel: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    );
  }

  @override
  String toString() {
    return "ReviewModel($idModel, $ratingModel, $userModel)";
  }

  @override
  List<Object?> get props => [
        idModel,
        ratingModel,
        userModel,
      ];
}

class UserModel extends UserEntity {
  const UserModel({
    this.idModel,
    this.imageUrlModel,
    this.nameModel,
  }) : super(
          id: idModel,
          imageUrl: imageUrlModel,
          name: nameModel,
        );

  final String? idModel;
  final String? imageUrlModel;
  final String? nameModel;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idModel: json["id"],
      imageUrlModel: json["image_url"],
      nameModel: json["name"],
    );
  }

  @override
  String toString() {
    return "UserModel($idModel, $imageUrlModel, $nameModel)";
  }

  @override
  List<Object?> get props => [
        idModel,
        imageUrlModel,
        nameModel,
      ];
}

class RestaurantQueryResultModel extends RestaurantQueryResultEntity
    with EquatableMixin {
  final int? totalModel;
  final List<RestaurantModel>? restaurantsModel;

  const RestaurantQueryResultModel({
    this.totalModel,
    this.restaurantsModel,
  }) : super(
          total: totalModel,
          restaurants: restaurantsModel,
        );

  factory RestaurantQueryResultModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? business = json["business"];
    if (business != null) {
      List<RestaurantModel> restaurants = business
          .map((dynamic item) => RestaurantModel.fromJson(item))
          .toList();
      return RestaurantQueryResultModel(restaurantsModel: restaurants);
    } else {
      return const RestaurantQueryResultModel(restaurantsModel: []);
    }
  }
}
