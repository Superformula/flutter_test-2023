import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:restaurantour/core/constants.dart';
import 'package:restaurantour/core/errors/exceptions.dart';
import 'package:restaurantour/data/data_source/restaurants_remote_data_source.dart';
import 'package:restaurantour/data/models/category_model.dart';
import 'package:restaurantour/data/models/restaurant_model.dart';
import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/data/models/user_model.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';

import '../../helpers/json_reader.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  late RestaurantRemoteDataSourceImpl restaurantRemoteDataSourceImpl;

  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    restaurantRemoteDataSourceImpl = RestaurantRemoteDataSourceImpl(dio: dio);
  });

  const userTest = UserModel(
    id: 'BuBCkWFNT_O2dbSnBZvpoQ',
    imageUrl:
        'https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg',
    name: 'Gina T.',
  );

  const userTest2 = UserModel(
    id: '0x9xu_b0Ct_6hG6jaxpztw',
    imageUrl:
        'https:///s3-media3.fl.yelpcdn.com/photo/gjz8X6tqE3e4praK4HfCiA/o.jpg',
    name: 'Crystal L.',
  );

  const reviewTestList = [
    ReviewModel(
      id: 'sjZoO8wcK1NeGJFDk5i82Q',
      rating: 5,
      user: userTest,
    ),
    ReviewModel(
      id: 'okpO9hfpxQXssbTZTKq9hA',
      rating: 5,
      user: userTest2,
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

  dioAdapter.onPost(
    '/v3/graphql',
    (server) {
      return server.reply(
        200,
        json.decode(
          readJson(
            'helpers/dummy_data.json',
          ),
        ),
      );
    },
    data: Urls.getQuery(),
    headers: {
      'Authorization': Urls.bearerToken,
      'Content-Type': 'application/graphql',
    },
  );

  group('Test Remote data source gets', () {
    test('Should return List of restaurants', () async {
      final result = await restaurantRemoteDataSourceImpl.getRestaurants();

      expect(result, [restaurantTest]);
    });

    test('Should return List of restaurants', () async {
      dioAdapter.onPost(
        '/v3/graphql',
        (server) {
          return server.reply(
            201,
            {'Error': 'erro'},
          );
        },
        data: Urls.getQuery(),
        headers: {
          'Authorization': Urls.bearerToken,
          'Content-Type': 'application/graphql',
        },
      );

      expect(
        () async => await restaurantRemoteDataSourceImpl.getRestaurants(),
        throwsA(
          isInstanceOf<ServerException>(),
        ),
      );
    });
  });
}
