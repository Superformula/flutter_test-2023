import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/data/repositories/restaurants_repository_impl.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late MockRestaurantsRemoteDataSource mockRestaurantsRemoteDataSource;
  late RestaurantsRepositoryImpl restaurantsRepositoryImpl;

  setUp(() {
    mockRestaurantsRemoteDataSource = MockRestaurantsRemoteDataSource();
    restaurantsRepositoryImpl = RestaurantsRepositoryImpl(restaurantsRemoteDataSource: mockRestaurantsRemoteDataSource);
  });
  
}