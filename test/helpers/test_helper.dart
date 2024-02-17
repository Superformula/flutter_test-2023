import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurantour/domain/repositories/restaurant_repository.dart';

@GenerateMocks([
  RestaurantsRepository,
],
// customMocks: [MockSpec(MockSpec<Dio.dioAdapter>(as: #MockDioClient))]
)

void main(){}