import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/data/data_sources/resturants_local_data_source.dart';
import 'package:restaurantour/app/data/storage/local_storage.dart';
import 'package:collection/collection.dart';

import '../../../../.fvm/versions/3.13.9/packages/flutter_tools/lib/src/convert.dart';
import '../mocks/resturant_query_result_factory.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockLocalStorage mockLocalStorage;
  late RestaurantsLocalDataSource localDataSource;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    localDataSource = SharedPreferencesRestaurantsLocalDataSource(mockLocalStorage);
  });

  final tRestaurant = ModelFactory.makeRestaurant();
  final tRestaurantsQueryResult = ModelFactory.makeRestaurantQueryResult();
  final tJsonRestaurants = jsonEncode(tRestaurantsQueryResult);
  final tJsonRestaurantsNull = jsonEncode(ModelFactory.makeRestaurantQueryResultNull());

  group('getRestaurantDetails: ', () {
    test(
        'should return a restaurant from getRestaurantDetails when'
        'has data available', () async {
      //arrange
      when(() => mockLocalStorage.fetchData(any())).thenAnswer((_) async => tJsonRestaurants);

      //act
      final result = await localDataSource.getRestaurantDetails(tRestaurant.id!);

      //assert
      expect(result, tRestaurant);
      verify(() => mockLocalStorage
          .fetchData(SharedPreferencesRestaurantsLocalDataSource.restaurantsCacheKey)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should throw EmptyDataException when'
        'queryResult.restaurants == null', () async {
      //arrange
      when(() => mockLocalStorage.fetchData(any())).thenAnswer((_) async => tJsonRestaurantsNull);

      //act
      final call = localDataSource.getRestaurantDetails;

      //assert
      expect(() => call(tRestaurant.id!), throwsA(isA<EmptyDataException>()));
      verify(() => mockLocalStorage
          .fetchData(SharedPreferencesRestaurantsLocalDataSource.restaurantsCacheKey)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should throw CacheException when'
        'localStorage throws CacheException', () async {
      //arrange
      when(() => mockLocalStorage.fetchData(any())).thenThrow(CacheException(''));

      //act
      final call = localDataSource.getRestaurantDetails;

      //assert
      expect(() => call(tRestaurant.id!), throwsA(isA<CacheException>()));
      verify(() => mockLocalStorage
          .fetchData(SharedPreferencesRestaurantsLocalDataSource.restaurantsCacheKey)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });
  });

  group('saveRestaurants: ', () {
    test('should call localStorage.saveData', () async {
      //arrange
      when(() => mockLocalStorage.saveData(any(), any())).thenAnswer((_) async => tJsonRestaurants);

      //act
      await localDataSource.saveRestaurants(tRestaurantsQueryResult);

      //assert
      verify(() => mockLocalStorage.saveData(
          SharedPreferencesRestaurantsLocalDataSource.restaurantsCacheKey,
          json.encode(tRestaurantsQueryResult))).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });
  });
}
