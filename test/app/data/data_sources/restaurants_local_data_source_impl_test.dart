import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/data/data_sources/resturants_local_data_source.dart';
import 'package:restaurantour/app/data/storage/local_storage.dart';

import '../../../../.fvm/versions/3.13.9/packages/flutter_tools/lib/src/convert.dart';
import '../mocks/resturant_query_result_factory.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockLocalStorage mockLocalStorage;
  late RestaurantsLocalDataSource localDataSource;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    localDataSource = RestaurantsLocalDataSourceImpl(mockLocalStorage);
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
      verify(() => mockLocalStorage.fetchData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey))
          .called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should throw EmptyDataException when'
        'queryResult.restaurants == null || queryResult.restaurants!.isEmpty', () async {
      //arrange
      when(() => mockLocalStorage.fetchData(any())).thenAnswer((_) async => tJsonRestaurantsNull);

      //act
      final call = localDataSource.getRestaurantDetails;

      //assert
      expect(() => call(tRestaurant.id!), throwsA(isA<EmptyDataException>()));
      verify(() => mockLocalStorage.fetchData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey))
          .called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should throw EmptyDataException when'
        'any id matches', () async {
      //arrange
      when(() => mockLocalStorage.fetchData(any())).thenAnswer((_) async => tJsonRestaurants);

      //act
      final call = localDataSource.getRestaurantDetails;

      //assert
      expect(() => call('anyId'), throwsA(isA<EmptyDataException>()));
      verify(() => mockLocalStorage.fetchData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey))
          .called(1);
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
      verify(() => mockLocalStorage.fetchData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey))
          .called(1);
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
      verify(() => mockLocalStorage.saveData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey,
          json.encode(tRestaurantsQueryResult))).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });
  });

  var tRestaurantIdList = ['id1, id2, vHz2RLtfUMVRPFmd7VBEHA'];

  group('addFavoriteRestaurant: ', () {
    test(
        'should add new restaurant id to the list when addFavoriteRestaurant'
        'is called', () async {
      //arrange
      when(() => mockLocalStorage.fetchListData(any())).thenAnswer((_) async => tRestaurantIdList);
      when(() => mockLocalStorage.saveList(any(), any())).thenAnswer((_) async => Future.value());

      //act
      await localDataSource.addFavoriteRestaurant(tRestaurant.id!);
      tRestaurantIdList.add(tRestaurant.id!);

      //assert
      verify(() => mockLocalStorage
          .fetchListData(RestaurantsLocalDataSourceImpl.favoriteRestaurantsCacheKey)).called(1);
      verify(() => mockLocalStorage.saveList(
          RestaurantsLocalDataSourceImpl.favoriteRestaurantsCacheKey, tRestaurantIdList)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test('should throw CacheException when localStorage throws CacheException', () async {
      //arrange
      when(() => mockLocalStorage.fetchListData(any())).thenThrow(CacheException(''));

      //act
      final call = localDataSource.addFavoriteRestaurant;

      //assert
      expect(() => call(tRestaurant.id!), throwsA(isA<CacheException>()));
      verify(() => mockLocalStorage
          .fetchListData(RestaurantsLocalDataSourceImpl.favoriteRestaurantsCacheKey)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });
  });

  group('getFavoriteRestaurants: ', () {
    test(
        'should return List<Restaurant> from getFavoriteRestaurants when'
        'has data available', () async {
      //arrange
      when(() => mockLocalStorage.fetchListData(any())).thenAnswer((_) async => tRestaurantIdList);
      when(() => mockLocalStorage.fetchData(any())).thenAnswer((_) async => tJsonRestaurants);

      //act
      final result = await localDataSource.getFavoriteRestaurants();

      //assert
      expect(result, [tRestaurant]);
      verify(() => mockLocalStorage.fetchData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey))
          .called(1);
      verify(() => mockLocalStorage
          .fetchListData(RestaurantsLocalDataSourceImpl.favoriteRestaurantsCacheKey)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should throw EmptyDataException when'
        'queryResult.restaurants == null || queryResult.restaurants!.isEmpty', () async {
      //arrange
      when(() => mockLocalStorage.fetchData(any())).thenAnswer((_) async => tJsonRestaurantsNull);

      //act
      final call = localDataSource.getFavoriteRestaurants;

      //assert
      expect(() => call(), throwsA(isA<EmptyDataException>()));
      verify(() => mockLocalStorage.fetchData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey))
          .called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should throw CacheException when'
        'localStorage throws CacheException', () async {
      //arrange
      when(() => mockLocalStorage.fetchData(any())).thenThrow(CacheException(''));

      //act
      final call = localDataSource.getFavoriteRestaurants;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
      verify(() => mockLocalStorage.fetchData(RestaurantsLocalDataSourceImpl.restaurantsCacheKey))
          .called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });
  });

  group('checkIfItIsFavoriteRestaurant: ', () {
    test('should return true if localStorage.fetchListData returned contains id', () async {
      //arrange
      when(() => mockLocalStorage.fetchListData(any())).thenAnswer((_) async => tRestaurantIdList);

      //act
      final result = await localDataSource.checkIfItIsFavoriteRestaurant(tRestaurantIdList.first);

      //assert
      expect(result, true);
      verify(() => mockLocalStorage
          .fetchListData(RestaurantsLocalDataSourceImpl.favoriteRestaurantsCacheKey)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should return false if localStorage.fetchListData returned does not '
        'contains id', () async {
      //arrange
      when(() => mockLocalStorage.fetchListData(any())).thenAnswer((_) async => tRestaurantIdList);

      //act
      final result = await localDataSource.checkIfItIsFavoriteRestaurant('idThatDoesNotExist');

      //assert
      expect(result, false);
      verify(() => mockLocalStorage
          .fetchListData(RestaurantsLocalDataSourceImpl.favoriteRestaurantsCacheKey)).called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });

    test(
        'should throw CacheException when'
        'localStorage throws CacheException', () async {
      //arrange
      when(() => mockLocalStorage.fetchListData(any())).thenThrow(CacheException(''));

      //act
      final call = localDataSource.checkIfItIsFavoriteRestaurant;

      //assert
      expect(() => call('id'), throwsA(isA<CacheException>()));
      verify(() => mockLocalStorage.fetchListData(RestaurantsLocalDataSourceImpl.favoriteRestaurantsCacheKey))
          .called(1);
      verifyNoMoreInteractions(mockLocalStorage);
    });
  });
}
