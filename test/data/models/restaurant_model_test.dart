import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/data/models/restaurant_model.dart';
import 'package:restaurantour/data/models/review_model.dart';
import 'package:restaurantour/data/models/user_model.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';

void main() {
  const userTest = UserModel(
    id: 'dW0QJVcKiX7crMd1lYWTkg',
    imageUrl: '',
    name: 'Misty C.',
  );

  const reviewTest = ReviewModel(
    id: 'DKtLdByPmlwZET_b4BM3gQ',
    rating: 5,
    user: userTest,
  );

  const restaurantTest = RestaurantModel(
    name: "Gordon Ramsay Hell's Kitchen'",
    price: r"$$$",
    rating: 4.4,
    photos: [''],
    review: <ReviewModel>[reviewTest],
  );

  test('Shoud be a ReviewEntity', () {
    expect(restaurantTest, isA<RestaurantEntity>());
  });


}
