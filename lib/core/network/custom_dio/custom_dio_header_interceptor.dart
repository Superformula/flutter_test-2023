import 'dart:io';
import 'package:dio/dio.dart';

class CustomDioHeaderInterceptor extends InterceptorsWrapper {
  CustomDioHeaderInterceptor();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    const _apiKey =
        'YkK5oI8SzhYMy3vXZuw-E_ot-iR7F69NoELiu2UsqPkYoEprQoqKGGFuZeQY4JlXEm2B9B2pd_CxJ5qmjodP9EMHZ3QiU1gGn6xjYXIvB7qjwhQbPBdDzINfUHDNZXYx';

    options.headers[HttpHeaders.contentTypeHeader] = 'application/graphql';
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $_apiKey';
    handler.next(options);
  }
}
