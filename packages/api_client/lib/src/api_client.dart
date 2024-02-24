import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

/// {@template api_client}
/// A Dio wrapper that provides a simple interface for making REST API calls
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  ApiClient({
    required this.httpClient,
    List<Interceptor>? interceptors,
  }) {
    interceptors?.forEach((element) {
      httpClient.interceptors.add(element);
    });
  }

  /// [Dio] used to communicate with the REST API
  final Dio httpClient;

  String get _baseUrl => httpClient.options.baseUrl;

  /// GET request to [path] with [queryParameters]
  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) async {
    late final Response<T> response;
    try {
      response = await httpClient.get(
        '$_baseUrl/$path',
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } catch (error, stackTrace) {
      _handleHttpError(
        (error is DioException) ? error.response?.statusCode ?? -1 : -1,
        error,
        stackTrace,
      );
    }

    return _handleResponse(response);
  }

  /// POST request to [path] with [queryParameters] and [body]
  Future<T?> post<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) async {
    late final Response<T> response;
    try {
      final optionsHeaders = <String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      if (headers != null) {
        optionsHeaders.addAll(headers);
      }

      response = await httpClient.post(
        '$_baseUrl/$path',
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: optionsHeaders),
      );
    } catch (error, stackTrace) {
      _handleHttpError(
        (error is DioException) ? error.response?.statusCode ?? -1 : -1,
        error,
        stackTrace,
      );
    }

    return _handleResponse(response);
  }

  /// PUT request to [path] with [queryParameters] and [body]
  Future<T?> put<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) async {
    late final Response<T> response;
    try {
      final optionsHeaders = <String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      if (headers != null) {
        optionsHeaders.addAll(headers);
      }

      response = await httpClient.put(
        '$_baseUrl/$path',
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: optionsHeaders),
      );
    } catch (error, stackTrace) {
      _handleHttpError(
        (error is DioException) ? error.response?.statusCode ?? -1 : -1,
        error,
        stackTrace,
      );
    }

    return _handleResponse(response);
  }

  /// DELETE request to [path] with [queryParameters] and [body]
  Future<T?> delete<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) async {
    late final Response<T> response;
    try {
      final optionsHeaders = <String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      if (headers != null) {
        optionsHeaders.addAll(headers);
      }

      response = await httpClient.delete(
        '$_baseUrl/$path',
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: optionsHeaders),
      );
    } catch (error, stackTrace) {
      _handleHttpError(
        (error is DioException) ? error.response?.statusCode ?? -1 : -1,
        error,
        stackTrace,
      );
    }

    return _handleResponse(response);
  }

  void _handleHttpError(
    int statusCode,
    Object error,
    StackTrace stackTrace,
  ) {
    final exception = switch (statusCode) {
      400 => BadRequestException(error),
      401 => UnauthorizedException(error),
      403 => ForbiddenException(error),
      _ => NetworkException(error),
    };

    Error.throwWithStackTrace(
      exception,
      error is DioException ? error.stackTrace : stackTrace,
    );
  }

  bool _isSuccessful(Response<dynamic> response) {
    final statusCode = response.statusCode ?? -1;
    return statusCode >= 200 && statusCode < 300;
  }

  T? _handleResponse<T>(Response<T> response) {
    final data = response.data;

    if (_isSuccessful(response)) {
      return data;
    } else {
      throw const DeserializationException.emptyResponseBody();
    }
  }
}
