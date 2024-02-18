import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/components/rt_image_network.dart';

import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/services/favorites_service.dart';

class RestaurantRepositoryMock extends Mock implements RestaurantRepository {}

class FavoritesServiceMock extends Mock implements FavoritesService {}

class DioMock extends Mock implements Dio {}

class RequestOptionsMock extends Mock implements RequestOptions {}

class RTImageNetworkMock extends Mock implements RTImageNetwork {
  @override
  Widget build({required String location, required Widget errorWidget}) => const Icon(Icons.image);
}
