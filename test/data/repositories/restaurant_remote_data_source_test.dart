import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/core/errors/exceptions.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/data/models/category_model.dart';
import 'package:restaurantour/data/models/restaurant_model.dart';
import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/data/models/user_model.dart';
import 'package:restaurantour/data/repositories/restaurants_repository_impl.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRestaurantsRemoteDataSource mockRestaurantsRemoteDataSource;
  late RestaurantsRepositoryImpl restaurantsRepositoryImpl;

  setUp(() {
    mockRestaurantsRemoteDataSource = MockRestaurantsRemoteDataSource();
    restaurantsRepositoryImpl = RestaurantsRepositoryImpl(
        restaurantsRemoteDataSource: mockRestaurantsRemoteDataSource);
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

  const restaurantEntity = RestaurantEntity(
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

  const restaurantModelList = <RestaurantModel>[restaurantTest];

  group('Get Restaurants List', () {
    test('Should Return RestaurantModel list when called', () async {
      when(mockRestaurantsRemoteDataSource.getRestaurants())
          .thenAnswer((realInvocation) async => restaurantModelList);

      final result = await restaurantsRepositoryImpl.getRestaurantsList();

      result.fold((l) => null, (r) {
        expect(r, equals([restaurantEntity]));
      });
    });

    test('Should Return ServerFailure when remote throw ServerException', () async {
      when(mockRestaurantsRemoteDataSource.getRestaurants())
          .thenThrow(ServerException());

      final result = await restaurantsRepositoryImpl.getRestaurantsList();

      result.fold(
        (l) {
          expect(l, isA<ServerFailure>());
        },
        (r) {},
      );
    });


    test('Should Return ServerFailure when remote throw SocketException', () async {
      when(mockRestaurantsRemoteDataSource.getRestaurants())
          .thenThrow(const SocketException('Could not Connect'));

      final result = await restaurantsRepositoryImpl.getRestaurantsList();

      result.fold(
        (l) {
          expect(l, isA<ConnectionFailure>());
        },
        (r) {},
      );
    });
  });
}
