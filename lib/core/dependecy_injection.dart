import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

const _apiKey = '';

void initDependencies() {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.yelp.com',
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/graphql',
      },
    ),
  );
  _getIt.registerFactory<Dio>(() => _dio);
}
