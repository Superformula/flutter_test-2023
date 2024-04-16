import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/utils/utils.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: AppWords.baseUrl,
      headers: {
        'Authorization': 'Bearer ${ApiKey.key}',
        'Content-Type': 'application/graphql',
      },
    );
    return dio;
  }
}
