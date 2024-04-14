import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/data/repositories/yelp_repository.dart';
import 'package:restaurantour/modules/home/domain/errors/erros.dart';
import 'package:restaurantour/modules/home/domain/repositories/restaurant_repository_interface.dart';

import '../../../../mocks/class_mocks.dart';

void main() {
  late Dio dioMock;
  late IRestaurantRepository restaurantRepository;

  setUp(() {
    dioMock = DioMock();
    restaurantRepository = YelpRepository(dio: dioMock);
  });
  group('[GET RESTAURANTS]', () {
    test('should returns a list of restaurants', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'id_test');
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: {
            'data': {
              'search': {
                'business': [restaurantMock.toJson()],
              },
            },
          },
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurants();

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.isNotEmpty, true);
      expect(response.data!.length, 1);
      expect(response.data!.first.id, restaurantMock.id);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a empty list of restaurants', () async {
      //Arrange
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: {
            'data': {
              'search': {
                'business': [],
              },
            },
          },
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurants();

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.isEmpty, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a empty list of restaurants when you reach the limit of requests in the api', () async {
      //Arrange
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenThrow(
        DioException.badResponse(
          statusCode: 403,
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: 403),
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurants();

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.isEmpty, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a exception when server has unexpected error', () async {
      //Arrange
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenThrow(
        DioException.badResponse(
          statusCode: 500,
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: 500),
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurants();

      //Assert
      expect(response.isError, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a exception when has unexpected error in the method', () async {
      //Arrange
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data')))
          .thenThrow(Exception('Unexpected error'));

      //Act
      final response = await restaurantRepository.getRestaurants();

      //Assert
      expect(response.isError, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });
  });

  group('[GET RESTAURANT BY ID]', () {
    test('should returns a restaurant', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'id_test');
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: {
            'data': {
              'business': restaurantMock.toJson(),
            },
          },
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurantById(id: restaurantMock.id!);

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.id, restaurantMock.id);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a not found exception when not found restaurant', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'id_test');
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: {
            'data': {
              'business': null,
            },
          },
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurantById(id: restaurantMock.id!);

      //Assert
      expect(response.isError, true);
      expect(response.error is NotFoundRestaurant, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a exception when you reach the limit of requests in the api', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'id_test');
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenThrow(
        DioException.badResponse(
          statusCode: 403,
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: 403),
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurantById(id: restaurantMock.id!);

      //Assert
      expect(response.isError, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a exception when server has unexpected error', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'id_test');
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenThrow(
        DioException.badResponse(
          statusCode: 500,
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: 500),
        ),
      );

      //Act
      final response = await restaurantRepository.getRestaurantById(id: restaurantMock.id!);

      //Assert
      expect(response.isError, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });

    test('should returns a exception when has unexpected error in the method', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'id_test');
      when(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data')))
          .thenThrow(Exception('Unexpected error'));

      //Act
      final response = await restaurantRepository.getRestaurantById(id: restaurantMock.id!);

      //Assert
      expect(response.isError, true);
      verify(() => dioMock.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).called(1);
    });
  });
}
