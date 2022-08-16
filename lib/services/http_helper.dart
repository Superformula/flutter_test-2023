import 'package:dio/dio.dart';
import 'package:superformula_flutter_test/constants.dart';

class HttpHelper {
  final String baseUrl;
  late final Dio dio;

  final Map<String, dynamic> headers = {'Authorization': 'Bearer $kYelpApiKey', 'Content-Type': 'application/graphql'};

  HttpHelper({required this.baseUrl}) {
    dio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));
  }

  Future<Response> post(String endpoint, [dynamic data]) async => dio.post(endpoint, data: data);

  Future<Response> get(String endpoint) async => dio.get(endpoint);
}
