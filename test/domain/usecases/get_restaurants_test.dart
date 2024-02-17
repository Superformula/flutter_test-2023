import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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

  const restaurantTest =  RestaurantEntity(
    name: "Gordon Ramsay Hell's Kitchen'",
    price:  r"$$$",
    rating: 4.4,
    photos: [''],
    review: <ReviewEntity>[],
  );

  test('Should get a restaurant list', () async{
    when(getRestaurantsUseCase.execute('')).thenAnswer((realInvocation) async=>  const Right([restaurantTest]));
  
    final result = await getRestaurantsUseCase.execute('');
  
    expect(result, const Right([restaurantTest]));

  });
}
