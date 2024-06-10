import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

abstract class RemoteRestaurantDataSource {
  Future<Response<Map<String, dynamic>>> getRestaurants(int offset);
}

class RemoteRestaurantDataSourceImpl extends RemoteRestaurantDataSource {
  RemoteRestaurantDataSourceImpl();

  final _dioClient = GetIt.instance<Dio>();

  @override
  Future<Response<Map<String, dynamic>>> getRestaurants(int offset) async {
    try {
      return await _dioClient.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );
    } catch (e) {
      rethrow;
    }
  }

  String _getQuery(int offset) {
    return '''
    query getRestaurants {
      search(location: "Las Vegas", limit: 20, offset: $offset) {
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
  }
}
