import 'package:dio/io.dart';
import 'package:restaurantour/core/network/custom_dio/custom_dio_header_interceptor.dart';
import 'custom_dio_logging_interceptor.dart';


class CustomDioCreator extends DioForNative {
  CustomDioCreator() {
    options.baseUrl = 'https://api.yelp.com';
    interceptors.add(
      CustomDioHeaderInterceptor(),
    );
    interceptors.add(CustomDioLoggingInteceptor());
  }
}