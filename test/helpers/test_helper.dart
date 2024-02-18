import 'package:mockito/annotations.dart';
import 'package:restaurantour/data/data_source/restaurants_remote_data_source.dart';
import 'package:restaurantour/domain/repositories/restaurant_repository.dart';

@GenerateMocks([
  RestaurantsRepository,
  RestaurantsRemoteDataSource,
],
// customMocks: [MockSpec(MockSpec<Dio.dioAdapter>(as: #MockDioClient))]
)

void main(){}