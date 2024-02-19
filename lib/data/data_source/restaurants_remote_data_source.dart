import 'package:dio/dio.dart';
import 'package:restaurantour/core/constants.dart';
import 'package:restaurantour/core/errors/exceptions.dart';
import 'package:restaurantour/data/models/restaurant_details_model.dart';
import 'package:restaurantour/data/models/restaurant_model.dart';

abstract class RestaurantsRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurants({int offset = 0});
  Future<RestaurantDetailsModel> getRestaurantDetails({required String id});
}

class RestaurantRemoteDataSourceImpl extends RestaurantsRemoteDataSource {
  final Dio dio;
  RestaurantRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<RestaurantModel>> getRestaurants({int offset = 0}) async {
    dio.options = BaseOptions(
      validateStatus: (status) => true,
      baseUrl: Urls.baseUrl,
      headers: {
        'Authorization': Urls.bearerToken,
        'Content-Type': 'application/graphql',
      },
    );

    final response = await dio.post<Map<String, dynamic>>(
      '/v3/graphql',
      data: Urls.getQuery(offset: offset),
    );
    if (response.statusCode == 200) {
      final result = List<RestaurantModel>.from(response.data!['data']['search']['business']
          .map((data) => RestaurantModel.fromJson(data))
          .toList(),);
      return result;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<RestaurantDetailsModel> getRestaurantDetails({required String id}) async{
     dio.options = BaseOptions(
      validateStatus: (status) => true,
      baseUrl: Urls.baseUrl,
      headers: {
        'Authorization': Urls.bearerToken,
        'Content-Type': 'application/graphql',
      },
    );
    final response = await dio.get(Urls.getDetailsUr(id));
    if (response.statusCode == 200){
       final result = RestaurantDetailsModel.fromJson(response.data);
       return result;
    }else{
      throw ServerException();
    }
  }
}
