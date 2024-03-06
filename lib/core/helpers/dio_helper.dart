import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.yelp.com',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['YELP_API_KEY']}',
        'Content-Type': 'application/graphql',
      },
    ),
  );

  static Dio get dio => _dio;
}
