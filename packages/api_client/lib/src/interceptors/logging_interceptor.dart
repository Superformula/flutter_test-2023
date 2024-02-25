// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';

/// {@template logging_interceptor}
/// Interceptor for log requests at [Dio] client.
/// {@endtemplate}
class LoggingInterceptor extends Interceptor {
  /// {@macro logging_interceptor}
  LoggingInterceptor({bool logEnabled = false}) : _logEnabled = logEnabled;

  final bool _logEnabled;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (_logEnabled) {
      print('[Dio] HTTP Request - ${options.method} ${options.path}');
      print('[Dio] headers - ${json.encode(options.headers)}');
      print('[Dio] queryParameters - ${json.encode(options.queryParameters)}');
      print('[Dio] body - ${json.encode(options.data)}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (_logEnabled) {
      print('[Dio] HTTP Response - ${response.statusCode} ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (_logEnabled) {
      print(
        '[Dio] HTTP Error - ${err.response?.statusCode} '
        '[${err.type}] ${err.error}',
      );
    }
    super.onError(err, handler);
  }
}
