import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/app/core/error/error_messages.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/core/error/failures.dart';
import 'package:restaurantour/app/data/data_sources/resturants_local_data_source.dart';
import 'package:restaurantour/app/data/data_sources/resturants_remote_data_source.dart';
import 'package:restaurantour/app/data/repositories/restaurants_repository_impl.dart';
import 'package:restaurantour/app/data/services/network_info_service.dart';
import 'package:restaurantour/app/interactor/models/restaurant.dart';
import 'package:restaurantour/app/interactor/repositories/restaurants_repository.dart';
import 'package:collection/collection.dart';

import '../mocks/resturant_query_result_factory.dart';

class MockRestaurantsRemoteDataSource extends Mock implements RestaurantsRemoteDataSource {}

class MockNetworkInfoService extends Mock implements NetworkInfoService {}

class MockRestaurantsLocalDataSource extends Mock implements RestaurantsLocalDataSource {}

class FakeRestaurantQueryResult extends Fake implements RestaurantQueryResult {}

void main() {
  late MockNetworkInfoService mockNetworkInfoService;
  late MockRestaurantsRemoteDataSource mockRemoteDataSource;
  late MockRestaurantsLocalDataSource mockLocalDataSource;
  late RestaurantsRepository repository;

  setUp(() async {
    mockNetworkInfoService = MockNetworkInfoService();
    mockRemoteDataSource = MockRestaurantsRemoteDataSource();
    mockLocalDataSource = MockRestaurantsLocalDataSource();
    repository = RestaurantsRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockNetworkInfoService,
    );
    registerFallbackValue(FakeRestaurantQueryResult());
  });

  whenNetworkInfoConnected() {
    when(() => mockNetworkInfoService.isConnected()).thenAnswer((_) async => true);
  }

  whenNetworkInfoMockNotConnected() {
    when(() => mockNetworkInfoService.isConnected()).thenAnswer((_) async => false);
  }

  final tRestaurantQueryResult = ModelFactory.makeRestaurantQueryResult();
  final tRestaurant = ModelFactory.makeRestaurant();

  group('getRestaurants: ', () {
    test(
        'should return (null, RestaurantListFailure) '
        'when networkInfoService.isConnected() is false', () async {
      //arrange
      whenNetworkInfoMockNotConnected();

      //act
      final result = await repository.getRestaurants();

      //assert
      expect(result, (null, const RestaurantListFailure(ErrorMessages.noInternetConnection)));

      verify(() => mockNetworkInfoService.isConnected()).called(1);
      verifyNoMoreInteractions(mockNetworkInfoService);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test(
        'should return (List<Restaurant>?, null) '
        'when networkInfoService.isConnected() is true '
        'and remoteDataSource returns RestaurantQueryResult', () async {
      //arrange
      whenNetworkInfoConnected();
      when(() => mockRemoteDataSource.getRestaurants())
          .thenAnswer((_) async => tRestaurantQueryResult);
      when(() => mockLocalDataSource.saveRestaurants(any()))
          .thenAnswer((_) async => Future.value());

      //act
      final result = await repository.getRestaurants();

      //assert
      expect(result, (tRestaurantQueryResult.restaurants, null));

      verify(() => mockNetworkInfoService.isConnected()).called(1);
      verify(() => mockRemoteDataSource.getRestaurants()).called(1);
      verify(() => mockLocalDataSource.saveRestaurants(tRestaurantQueryResult)).called(1);
      verifyNoMoreInteractions(mockNetworkInfoService);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test(
        'should return (null, RestaurantListFailure) '
        'when networkInfoService.isConnected() is true '
        'and remoteDataSource throws ServerException', () async {
      //arrange
      whenNetworkInfoConnected();
      when(() => mockRemoteDataSource.getRestaurants())
          .thenThrow(ServerException(ErrorMessages.serverException));

      //act
      final result = await repository.getRestaurants();

      //assert
      expect(result, (null, const RestaurantListFailure(ErrorMessages.serverException)));

      verify(() => mockNetworkInfoService.isConnected()).called(1);
      verify(() => mockRemoteDataSource.getRestaurants()).called(1);
      verifyNoMoreInteractions(mockNetworkInfoService);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('getRestaurantDetails: ', () {
    test(
        'should return (Restaurant?, null) '
        'when LocalDataSource returns Restaurant', () async {
      //arrange
      when(() => mockLocalDataSource.getRestaurantDetails(any()))
          .thenAnswer((_) async => tRestaurant);

      //act
      final result = await repository.getRestaurantDetails('id');

      //assert
      expect(result, (tRestaurant, null));

      verify(() => mockLocalDataSource.getRestaurantDetails('id')).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });

    test(
        'should return (null, RestaurantListFailure) '
        'and localDataSource throws EmptyDataException', () async {
      //arrange
      when(() => mockLocalDataSource.getRestaurantDetails(any()))
          .thenThrow(EmptyDataException('message'));

      //act
      final result = await repository.getRestaurantDetails('id');

      //assert
      expect(result, (null, const RestaurantDetailsFailure('message')));

      verify(() => mockLocalDataSource.getRestaurantDetails('id')).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });

    test(
        'should return (null, RestaurantListFailure) '
        'and localDataSource throws CacheException', () async {
      //arrange
      when(() => mockLocalDataSource.getRestaurantDetails(any()))
          .thenThrow(CacheException('message'));

      //act
      final result = await repository.getRestaurantDetails('id');

      //assert
      expect(result, (null, const RestaurantDetailsFailure(ErrorMessages.cacheException)));

      verify(() => mockLocalDataSource.getRestaurantDetails('id')).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });

    test(
        'should return (null, RestaurantListFailure) '
        'and localDataSource throws unknown Exception', () async {
      //arrange
      when(() => mockLocalDataSource.getRestaurantDetails(any())).thenThrow(Exception('message'));

      //act
      final result = await repository.getRestaurantDetails('id');

      //assert
      expect(result, (null, const RestaurantDetailsFailure(ErrorMessages.unknownException)));

      verify(() => mockLocalDataSource.getRestaurantDetails('id')).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });
  });

  group('getFavoriteRestaurants: ', () {
    test(
        'should return (List<Restaurant>?, null) '
        'when LocalDataSource returns List<Restaurant>', () async {
      //arrange
      when(() => mockLocalDataSource.getFavoriteRestaurants())
          .thenAnswer((_) async => [tRestaurant]);

      //act
      final result = await repository.getFavoriteRestaurants();
      print(result.$1.toString());
      print([tRestaurant].toString());
      print(result.$1 == [tRestaurant]);

      //assert
      expect(const ListEquality().equals(result.$1, [tRestaurant]), true);

      verify(() => mockLocalDataSource.getFavoriteRestaurants()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });

    test(
        'should return (null, FavoriteRestaurantsFailure) '
        'and localDataSource throws EmptyDataException', () async {
      //arrange
      when(() => mockLocalDataSource.getFavoriteRestaurants())
          .thenThrow(EmptyDataException('message'));

      //act
      final result = await repository.getFavoriteRestaurants();

      //assert
      expect(result, (null, const FavoriteRestaurantsFailure('message')));

      verify(() => mockLocalDataSource.getFavoriteRestaurants()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });

    test(
        'should return (null, FavoriteRestaurantsFailure) '
        'and localDataSource throws CacheException', () async {
      //arrange
      when(() => mockLocalDataSource.getFavoriteRestaurants()).thenThrow(CacheException('message'));

      //act
      final result = await repository.getFavoriteRestaurants();

      //assert
      expect(result, (null, const FavoriteRestaurantsFailure(ErrorMessages.cacheException)));

      verify(() => mockLocalDataSource.getFavoriteRestaurants()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });

    test(
        'should return (null, FavoriteRestaurantsFailure) '
        'and localDataSource throws unknown Exception', () async {
      //arrange
      when(() => mockLocalDataSource.getFavoriteRestaurants()).thenThrow(Exception('message'));

      //act
      final result = await repository.getFavoriteRestaurants();

      //assert
      expect(result, (null, const FavoriteRestaurantsFailure(ErrorMessages.unknownException)));

      verify(() => mockLocalDataSource.getFavoriteRestaurants()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfoService);
    });
  });
}
