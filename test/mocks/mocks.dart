import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/routes.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantRepositoryMock extends Mock implements RestaurantRepository {}

class FavoritesServiceMock extends Mock implements FavoriteService {}

class DioMock extends Mock implements Dio {}

class EventBusServiceMock extends Mock implements EventBusService {}

class RequestOptionsMock extends Mock implements RequestOptions {}

class GoRouterConfigMock extends Mock implements GoRouterConfig {}

class SharedPreferencesMock extends Mock implements SharedPreferences {}

class RTImageNetworkMock extends Mock implements RTImageNetwork {
  @override
  Widget build({required String location, required Widget errorWidget}) => const Icon(Icons.image);
}
