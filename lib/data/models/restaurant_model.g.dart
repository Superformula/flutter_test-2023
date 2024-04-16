// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      alias: json['alias'] as String?,
      title: json['title'] as String?,
      aliasModel: json['aliasModel'] as String?,
      titleModel: json['titleModel'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'title': instance.title,
      'aliasModel': instance.aliasModel,
      'titleModel': instance.titleModel,
    };

HoursModel _$HoursModelFromJson(Map<String, dynamic> json) => HoursModel(
      isOpenNowModel: json['is_open_now'] as bool?,
    );

Map<String, dynamic> _$HoursModelToJson(HoursModel instance) =>
    <String, dynamic>{
      'is_open_now': instance.isOpenNowModel,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
      idModel: json['idModel'] as String?,
      imageUrlModel: json['image_url'] as String?,
      nameModel: json['nameModel'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'idModel': instance.idModel,
      'image_url': instance.imageUrlModel,
      'nameModel': instance.nameModel,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as String?,
      rating: json['rating'] as int?,
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      idModel: json['idModel'] as String?,
      ratingModel: json['ratingModel'] as int?,
      userModel: json['userModel'] == null
          ? null
          : UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'user': instance.user,
      'idModel': instance.idModel,
      'ratingModel': instance.ratingModel,
      'userModel': instance.userModel,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      formattedAddress: json['formattedAddress'] as String?,
      formattedAddressModel: json['formatted_address'] as String?,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'formattedAddress': instance.formattedAddress,
      'formatted_address': instance.formattedAddressModel,
    };

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      hours: (json['hours'] as List<dynamic>?)
          ?.map((e) => HoursEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      idModel: json['idModel'] as String?,
      nameModel: json['nameModel'] as String?,
      priceModel: json['priceModel'] as String?,
      ratingModel: (json['ratingModel'] as num?)?.toDouble(),
      photosModel: (json['photosModel'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoriesModel: (json['categoriesModel'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hoursModel: (json['hoursModel'] as List<dynamic>?)
          ?.map((e) => HoursModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewsModel: (json['reviewsModel'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      locationModel: json['locationModel'] == null
          ? null
          : LocationModel.fromJson(
              json['locationModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'rating': instance.rating,
      'photos': instance.photos,
      'categories': instance.categories,
      'hours': instance.hours,
      'reviews': instance.reviews,
      'location': instance.location,
      'idModel': instance.idModel,
      'nameModel': instance.nameModel,
      'priceModel': instance.priceModel,
      'ratingModel': instance.ratingModel,
      'photosModel': instance.photosModel,
      'categoriesModel': instance.categoriesModel,
      'hoursModel': instance.hoursModel,
      'reviewsModel': instance.reviewsModel,
      'locationModel': instance.locationModel,
    };

RestaurantQueryResultModel _$RestaurantQueryResultModelFromJson(
        Map<String, dynamic> json) =>
    RestaurantQueryResultModel(
      total: json['total'] as int?,
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((e) => RestaurantEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalModel: json['totalModel'] as int?,
      restaurantsModel: (json['business'] as List<dynamic>?)
          ?.map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantQueryResultModelToJson(
        RestaurantQueryResultModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'restaurants': instance.restaurants,
      'totalModel': instance.totalModel,
      'business': instance.restaurantsModel,
    };
