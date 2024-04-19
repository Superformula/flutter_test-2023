import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LogInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    kDebugMode ? print(data.toString()) : null;
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    kDebugMode ? print(data.toString()) : null;
    return data;
  }
}
