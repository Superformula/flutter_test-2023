/// Copyright 2022 - Superformula. All rights reserved.
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

void main() {
  Restaurant _restaurantModel;
  YelpRepository _yelpRepository;

  /// Registers a function to be run before tests.
  setUp(() {
  });

  group("Unit Test Restaurants", () {
    test("[Model] Check individual values", () async{

      //define the Restaurat map as a passing argument
      Map<String, dynamic> rMap = {
        'id': 'fdfd',
        'name': 'one',
        'price': '',
        'rating': 5.0,
        'photos': ['http://rest.png'],
        'categories': [{'title': '', 'alias': ''}],
        'hours': [{'isOpenNow': true}],
        'reviews': [],
        'location': {'formattedAddress': ''}
      };

      //Get the Restaurant object by calling Restaurant factory
      _restaurantModel = Restaurant.fromJson(rMap);
      //Begin Tests
      expect(_restaurantModel.heroImage, 'http://rest.png');
      expect(_restaurantModel.name, 'one');
    });

    ///Test Yelp Repository
    test("Test Yelp Repository", () async{
      _yelpRepository = YelpRepository();
      var result = await _yelpRepository.getRestaurants();
      expect(result, isNotNull);
      if(result!= null) {
        var restaurants =result.restaurants;
        expect(restaurants, isNotNull);
        if(restaurants!=null)
          expect(restaurants.length, 20);
      }

    });
  });
}
