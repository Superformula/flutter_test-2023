import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/constants/constants.dart';

@module
abstract class InjectableModules {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: 'https://api.yelp.com',
          headers: {
            'Authorization': 'Bearer ${Constants.apiKey}',
            'Content-Type': 'application/graphql',
          },
        ),
      );
}
