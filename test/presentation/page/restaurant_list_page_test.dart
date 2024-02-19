import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurantour/data/models/category_model.dart';
import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/data/models/user_model.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/pages/widgets/restaurant_list_widget.dart';

class MockRestaurantsBloc extends MockBloc<RestaurantsEvent, RestaurantsState>
    implements RestaurantsBloc {}

main() {
  late MockRestaurantsBloc mockRestaurantsBloc;

  setUp(() {
    mockRestaurantsBloc = MockRestaurantsBloc();
    HttpOverrides.global = null;
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<RestaurantsBloc>(
      create: (context) => mockRestaurantsBloc,
      child: MaterialApp(home: body),
    );
  }

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
  testWidgets(
    'test should trigger loading',
    (widgetTester) async {
      when(() => mockRestaurantsBloc.state).thenReturn(RestaurantsLoading());

      await widgetTester
          .pumpWidget(_makeTestableWidget(const RestaurantListWidget()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'test should trigger loading and then show data',
    (widgetTester) async {
      when(() => mockRestaurantsBloc.state)
          .thenReturn(const RestaurantsLoaded([restaurantEntity]));
      await mockNetworkImagesFor(
        () async => widgetTester
            .pumpWidget(_makeTestableWidget(const RestaurantListWidget())),
      );

      expect(find.byType(ListView), findsOneWidget);
    },
  );

  testWidgets(
    'test should trigger loading and then show data',
    (widgetTester) async {
      when(() => mockRestaurantsBloc.state)
          .thenReturn(const RestaurantsLoadFail('Error'));

      await widgetTester
          .pumpWidget(_makeTestableWidget(const RestaurantListWidget()));

      expect(find.byKey(const Key('error')), findsOneWidget);
    },
  );
}
