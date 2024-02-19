import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/app/core/error/exceptions.dart';
import 'package:restaurantour/app/data/data_sources/resturants_remote_data_source.dart';

import '../mocks/resturant_query_result_factory.dart';

class MockDio extends Mock implements Dio {}

main() {
  late MockDio mockDio;
  late RestaurantsRemoteDataSource dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = YelpRestaurantsRemoteDataSource(mockDio);
  });

  final tRestaurantQueryResult = ModelFactory.makeRestaurantQueryResult();

  test('should return a RestaurantQueryResult ', () async {
    //arrange
    when(() => mockDio.post<Map<String, dynamic>>(any(), data: any(named: 'data'))).thenAnswer(
      (_) async =>
          Response(data: jsonDecode(jsonRestaurantQueryResult), requestOptions: RequestOptions()),
    );

    //act
    final result = await dataSource.getRestaurants();

    //assert
    expect(result, tRestaurantQueryResult);

    verify(
      () => mockDio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: data,
        queryParameters: null,
        options: null,
        cancelToken: null,
        onSendProgress: null,
        onReceiveProgress: null,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockDio);
  });

  test('should throw a ServerException when dio.post throws some Exception ', () async {
    //arrange
    when(() => mockDio.post<Map<String, dynamic>>(any(), data: any(named: 'data')))
        .thenThrow(Exception());

    //act
    final call = dataSource.getRestaurants;

    //assert
    expect(() => call(), throwsA(const TypeMatcher<ServerException>()));

    verify(
      () => mockDio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: data,
        queryParameters: null,
        options: null,
        cancelToken: null,
        onSendProgress: null,
        onReceiveProgress: null,
      ),
    ).called(1);

    verifyNoMoreInteractions(mockDio);
  });
}

const data = '''
query getRestaurants {
  search(location: "Las Vegas", limit: 20, offset: 0) {
    total    
    business {
      id
      name
      price
      rating
      photos
      reviews {
        id
        rating
        user {
          id
          image_url
          name
        }
      }
      categories {
        title
        alias
      }
      hours {
        is_open_now
      }
      location {
        formatted_address
      }
    }
  }
}
''';
