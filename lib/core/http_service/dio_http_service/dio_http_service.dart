import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/error/error.dart';
import 'package:restaurantour/core/http_service/http_service.dart';
import 'package:restaurantour/core/utils/utils.dart';

@LazySingleton(as: HttpService)
class DioHttpService implements HttpService {
  final Dio _dio;

  DioHttpService(
    this._dio,
  );

  @override
  Future post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return Future.value(response.data);
    } catch (e) {
      throw RestaurantsListException(
        message: '${AppWords.failedToPerformPostRequest} $e',
      );
    }
  }
}
