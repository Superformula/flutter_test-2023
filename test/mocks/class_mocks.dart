import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/core/services/local_storage/local_storage_interface.dart';
import 'package:restaurantour/modules/home/domain/repositories/restaurant_repository_interface.dart';
import 'package:restaurantour/modules/home/domain/stores/favorite_store.dart';

class DioMock extends Mock implements Dio {}

class FavoriteStoreMock extends Mock implements FavoriteStore {}

class ResturantRepositoryMock extends Mock implements IRestaurantRepository {}

class LocalStorageServiceMock extends Mock implements ILocalStorageService {}
