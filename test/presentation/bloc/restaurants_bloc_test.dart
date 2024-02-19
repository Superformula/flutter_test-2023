import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/core/errors/failures.dart';
import 'package:restaurantour/data/models/category_model.dart';
import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/data/models/user_model.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late MockGetRestaurantsUseCase mockRestaurantsRemoteDataSource;
  late RestaurantsBloc restaurantsBloc;

  setUp(() {
    mockRestaurantsRemoteDataSource = MockGetRestaurantsUseCase();
    restaurantsBloc = RestaurantsBloc(mockRestaurantsRemoteDataSource);
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
      text: ''
    ),
    ReviewModel(
      id: 'okpO9hfpxQXssbTZTKq9hA',
      rating: 5,
      user: userTest2,
      text: ''
    ),
  ];

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

  const restaurantEntityList = <RestaurantEntity>[restaurantEntity];

  test('Initial State should be  RestaurantsEmpty', () {
    expect(restaurantsBloc.state, RestaurantsEmpty());
  });

  blocTest<RestaurantsBloc, RestaurantsState>(
    'Should emit [RestaurantLoading,RestaurantLoaded] when data resturned',
    build: () {
      when(mockRestaurantsRemoteDataSource.execute()).thenAnswer(
        (realInvocation) async => const Right(restaurantEntityList),
      );
      return restaurantsBloc;
    },
    act: ((bloc) => bloc.add(
          const OnRequestedRestaurants(),
        )),
    expect: () => [
      RestaurantsLoading(),
      const RestaurantsLoaded(restaurantEntityList),
    ],
  );

    blocTest<RestaurantsBloc, RestaurantsState>(
    'Should emit [RestaurantLoading,RestaurantLoaded] when data resturned',
    build: () {
      when(mockRestaurantsRemoteDataSource.execute()).thenAnswer(
        (realInvocation) async => const Left(ServerFailure('Error')),
      );
      return restaurantsBloc;
    },
    act: ((bloc) => bloc.add(
          const OnRequestedRestaurants(),
        )),
    expect: () => [
      RestaurantsLoading(),
      const RestaurantsLoadFail('Error'),
    ],
  );
}
