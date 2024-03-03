import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:restaurantour/core/logger.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    RTLogger.e(message: 'onError: ${options.method} request => $requestPath', exception: err);
    RTLogger.e(message: 'onError: ${err.error}, Message: ${err.message}', exception: err);

    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    RTLogger.l(message: 'onRequest: ${options.method} request => $requestPath');
    RTLogger.l(message: 'onRequest: Request Headers => ${options.headers}');
    RTLogger.l(message: 'onRequest: Request Data => ${_prettyJsonEncode(options.data)}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    RTLogger.i(message: 'onResponse: StatusCode: ${response.statusCode}, Data: ${_prettyJsonEncode(response.data)}');

    return super.onResponse(response, handler);
  }

  String _prettyJsonEncode(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(data);
      return jsonString;
    } catch (e) {
      return data.toString();
    }
  }
}
