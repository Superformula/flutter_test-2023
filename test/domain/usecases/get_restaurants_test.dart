import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/data/models/category_model.dart';
import 'package:restaurantour/domain/entities/category_entity.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/entities/review_entity.dart';
import 'package:restaurantour/domain/usecases/get_restaurants.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetRestaurantsUseCase getRestaurantsUseCase;
  late MockRestaurantsRepository mockRestaurantsRepository;

  setUp(() {
    mockRestaurantsRepository = MockRestaurantsRepository();
    getRestaurantsUseCase = GetRestaurantsUseCase(mockRestaurantsRepository);
  });

    const restaurantEntity = RestaurantEntity(
    id: "faPVqws-x-5k2CQKDNtHxw",
    name: "Yardbird Southern Table & Bar",
    price: r"$$",
    rating: 4.5,
    photos: [
      'https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg',
    ],
    review: <ReviewEntity>[],
    isOpenNow: true,
    categories: <CategoryEntity>[
      CategoryModel(title: "New American", alias: "newamerican"),
    ],
  );

  test('Should get a restaurant list', () async{
    when(getRestaurantsUseCase.execute()).thenAnswer((realInvocation) async=>  const Right([restaurantEntity]));
  
    final result = await getRestaurantsUseCase.execute();
  
    expect(result, const Right([restaurantEntity]));

  });
}
