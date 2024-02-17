import 'package:dio/dio.dart';

class CustomDioLoggingInteceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      '(ERROR) <--- ${err.response?.requestOptions.baseUrl}${err.response?.requestOptions.path} | statuscode: ${err.response?.statusCode} data: ${err.response?.data} headers: ${err.response?.headers}',
    );
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
      '(REQUEST) ---> ${options.baseUrl}${options.path} | headers: ${options.headers} data: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '(RESPONSE) <--- ${response.requestOptions.baseUrl}${response.requestOptions.path} | statuscode: ${response.statusCode} | headers: ${response.headers} data: ${response.data}',
    );
    handler.next(response);
  }
}
