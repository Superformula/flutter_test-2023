import 'package:dio/dio.dart';
import 'package:oxidized/oxidized.dart';
import 'package:restaurantour/core/helpers/dio_helper.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/restaurant_model.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/repository/favorite_restaurante_repository.dart';

class FavoriteRestaurantsApi extends FavoriteRestaurantsRepository {
  final Dio dio;

  FavoriteRestaurantsApi({Dio? dio}) : dio = dio ?? DioHelper.dio;

  String _getRestaurantDetailsQuery(String restaurantId) {
    return '''
  {
    business(id: "$restaurantId") {
        id
        name
        price
        rating
        photos
        reviews {
          id
          rating
          text  
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
  ''';
  }

  @override
  Future<Result<RestaurantModel, DioException>> getRestaurantDetails({
    required String restaurantId,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getRestaurantDetailsQuery(restaurantId),
      );

      if (response.data != null) {
        final result = RestaurantModel.fromJson(response.data!);
        return Ok(result);
      } else {
        return Err(DioException(
          error: 'La respuesta no contiene datos',
          requestOptions: RequestOptions(path: '/v3/graphql'),
        ));
      }
    } on DioException catch (e) {
      return Err(e);
    } catch (e) {
      return Err(DioException(
        error: 'Error desconocido: $e',
        requestOptions: RequestOptions(path: '/v3/graphql'),
      ));
    }
  }
}
