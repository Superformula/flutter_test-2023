import 'package:restaurantour/models/restaurant.dart';
import 'test_utils.dart';

class TestFixture {
  Restaurant restaurant({
    String? id,
    String? name,
    String? price,
    double? rating,
    List<String>? photos,
    List<Category>? categories,
    List<Hours>? hours,
    List<Review>? reviews,
    Location? location,
  }) {
    return Restaurant(
      id: id ?? TestUtils.randomTxt(),
      name: name ?? TestUtils.randomTxt(),
      price: price ?? "\$\$\$",
      rating: rating ?? 3,
      photos: photos ?? [TestUtils.randomTxt()],
      categories: categories ?? [const Category()],
      hours: hours ?? [const Hours(isOpenNow: true)],
      reviews: reviews ?? [const Review()],
      location: location ?? const Location(),
    );
  }
}
