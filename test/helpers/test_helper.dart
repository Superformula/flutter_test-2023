import 'package:mockito/annotations.dart';
import 'package:restaurantour/data/data_source/restaurants_remote_data_source.dart';
import 'package:restaurantour/domain/repositories/restaurant_repository.dart';
import 'package:restaurantour/domain/usecases/get_restaurants.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';

@GenerateMocks(
  [
    RestaurantsRepository,
    RestaurantsRemoteDataSource,
    GetRestaurantsUseCase,
    RestaurantsBloc,
  ],
// customMocks: [MockSpec(MockSpec<Dio.dioAdapter>(as: #MockDioClient))]
)
void main() {}
