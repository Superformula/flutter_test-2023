import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

const _apiKey =
    'adc6IVk1OhheUDmDlY0PNelkBh5qFfp9hWGAv9zoRbJCrMYcJk8ckbnANWFHWxDdxXwn4tLFtfMbAHiGAEu2XWKQpT3HK-dxm9QTt85ecrb7HEl1a-40SwiCcldnZnYx';

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
