import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

import 'fixture.dart';

enum _YelpRepositoryState {
  withData,
  noData,
  error,
}

class YelpRepositoryMock extends YelpRepository {
  YelpRepositoryMock.withData() : _state = _YelpRepositoryState.withData;

  YelpRepositoryMock.noData() : _state = _YelpRepositoryState.noData;

  YelpRepositoryMock.error() : _state = _YelpRepositoryState.error;

  final _YelpRepositoryState _state;

  static getMockedRestaurants(int howMany) {
    var fixture = TestFixture();
    var restaurants = <Restaurant>[];
    for (var i = 0; i < 3; i++) {
      restaurants.add(fixture.restaurant());
    }
    return restaurants;
  }

  @override
  Future<List<Restaurant>?> getRestaurants({int offset = 0}) async {
    //
    switch (_state) {
      case _YelpRepositoryState.withData:
        return getMockedRestaurants(3);

      case _YelpRepositoryState.noData:
        return [];

      case _YelpRepositoryState.error:
        throw Error();

      default:
        throw Exception('Unknown state $_state');
    }
  }
}
