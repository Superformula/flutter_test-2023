import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:api_client/api_client.dart';

@module
abstract class RestApiServiceModule {
  @singleton
  @preResolve
  Future<ApiClient> apliClientService() async => ApiClient(
        httpClient: Dio(
          BaseOptions(
            baseUrl: 'https://api.yelp.com',
            headers: {
              'Authorization':
                  'Bearer ${const String.fromEnvironment('API_KEY')}',
              'Content-Type': 'application/graphql',
            },
          ),
        ),
        interceptors: [
          LoggingInterceptor(
            logEnabled: true,
          ),
        ],
      );
}
