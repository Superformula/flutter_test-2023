import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/data/models/category_model.dart';
import 'package:restaurantour/data/models/restaurant_model.dart';
import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/data/models/user_model.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

import '../../helpers/json_reader.dart';

void main() {
  const userTest = UserModel(
    id: 'BuBCkWFNT_O2dbSnBZvpoQ',
    imageUrl: 'https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg',
    name: 'Gina T.',
  );

    const userTest2 = UserModel(
    id: '0x9xu_b0Ct_6hG6jaxpztw',
    imageUrl: 'https:///s3-media3.fl.yelpcdn.com/photo/gjz8X6tqE3e4praK4HfCiA/o.jpg',
    name: 'Crystal L.',
  );

  const reviewTestList = [
    ReviewModel(
      id: 'sjZoO8wcK1NeGJFDk5i82Q',
      rating: 5,
      user: userTest,
      text: ''
    ),
    ReviewModel(
      id: 'okpO9hfpxQXssbTZTKq9hA',
      rating: 5,
      user: userTest2,
      text: ''
    ),
  ];

  const restaurantTest = RestaurantModel(
    id: "faPVqws-x-5k2CQKDNtHxw",
    name: "Yardbird Southern Table & Bar",
    price: r"$$",
    rating: 4.5,
    photos: [
      'https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg',
    ],
    review: reviewTestList,
    isOpenNow: true,
    categories: <CategoryEntity>[
      CategoryModel(title: "New American", alias: "newamerican"),
    ],
  );

  test('Shoud be a ReviewEntity', () {
    expect(restaurantTest, isA<RestaurantEntity>());
  });

  test('Shoud return restaurant model from json', () {
    final Map<String, dynamic> jsonMap = json.decode(
      readJson(
        'helpers/dummy_data.json',
      ),
    );

    final result =
        RestaurantModel.fromJson(jsonMap['data']['search']['business'].first);

    expect(result, equals(restaurantTest));
  });
}
