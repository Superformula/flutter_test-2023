import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/common/constants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/screens/restaurant_details/restaurant_details_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tabs_vm/tabs_vm_test.mocks.dart';

@GenerateMocks([YelpRepository])
void main() {
  final _mockYelpRepository = MockYelpRepository();

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  test(
    'test toggleFavorite add favorite',
    () async {
      final vm = RestaurantDetailsVM();

      SharedPreferences.setMockInitialValues(
        {
          kFavoriteRestaurantsKey: [],
        },
      );

      vm.setYelpRepository(_mockYelpRepository);

      when(
        _mockYelpRepository.getFavoriteRestaurantsIds(),
      ).thenAnswer(
        (_) => Future.value(
          [],
        ),
      );

      final restaurant = Restaurant.fromJson(fakeRestaurant);

      vm.init(restaurant);

      await vm.toggleFavorite();

      verify(_mockYelpRepository.getFavoriteRestaurantsIds());
      verify(
        _mockYelpRepository.setFavoriteRestaurantsIds(
          [restaurant.id ?? kEmptyString],
        ),
      );
    },
  );

  test(
    'test toggleFavorite remove favorite',
    () async {
      final vm = RestaurantDetailsVM();

      SharedPreferences.setMockInitialValues(
        {
          kFavoriteRestaurantsKey: ["vHz2RLtfUMVRPFmd7VBEHA"],
        },
      );

      vm.setYelpRepository(_mockYelpRepository);

      when(
        _mockYelpRepository.getFavoriteRestaurantsIds(),
      ).thenAnswer(
        (_) => Future.value(
          ["vHz2RLtfUMVRPFmd7VBEHA"],
        ),
      );

      final restaurant = Restaurant.fromJson(fakeRestaurant);

      vm.init(restaurant);

      await vm.toggleFavorite();

      verify(_mockYelpRepository.getFavoriteRestaurantsIds());
      verify(
        _mockYelpRepository.setFavoriteRestaurantsIds(
          [],
        ),
      );
    },
  );
}

Map<String, dynamic> get fakeRestaurant => {
      "id": "vHz2RLtfUMVRPFmd7VBEHA",
      "name": "Gordon Ramsay Hell's Kitchen",
      "price": '\$\$\$',
      "rating": 4.4,
      "photos": [
        "https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg",
      ],
      "reviews": [
        {
          "id": "VzJIMZRW-8lwoFJzk0jAXw",
          "rating": 5,
          "user": {
            "id": "i2dS47auJ-9-OW4xZSPxAA",
            "image_url":
                "https://s3-media1.fl.yelpcdn.com/photo/M2AsmeEgwVwpjyaE1lFtIA/o.jpg",
            "name": "White R.",
          },
        },
        {
          "id": "H85bnGMvTx0ACssHvyCyug",
          "rating": 5,
          "user": {
            "id": "3xfzp3cOhKICnLn0D9ZheA",
            "image_url": null,
            "name": "Molly S.",
          },
        },
        {
          "id": "O60EsMnhEmrSs4F54imSkw",
          "rating": 3,
          "user": {
            "id": "C8e7rVhQY6lMYm-yn1luJQ",
            "image_url": null,
            "name": "Taylor T.",
          },
        }
      ],
      "categories": [
        {"title": "New American", "alias": "newamerican"},
        {"title": "Seafood", "alias": "seafood"},
      ],
      "hours": [
        {"is_open_now": true},
      ],
      "location": {
        "formatted_address": "3570 Las Vegas Blvd S\nLas Vegas, NV 89109",
      },
    };
