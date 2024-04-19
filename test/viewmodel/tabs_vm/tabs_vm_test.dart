import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantour/common/constants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/screens/tabs/tabs_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tabs_vm_test.mocks.dart';

@GenerateMocks([YelpRepository])
void main() {
  final mockYelpRepository = MockYelpRepository();
  final tabsVM = TabsVM();

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  test(
    'test getRestaurants Success and getFavoriteRestaurantsIds empty',
    () async {
      SharedPreferences.setMockInitialValues(
        {
          kFavoriteRestaurantsKey: [],
        },
      );

      tabsVM.setYelpRepository(mockYelpRepository);

      when(
        mockYelpRepository.getRestaurants(),
      ).thenAnswer(
        (_) => Future.value(
          RestaurantQueryResult.fromJson(fakeRestaurants),
        ),
      );

      when(
        mockYelpRepository.getFavoriteRestaurantsIds(),
      ).thenAnswer(
        (_) => Future.value(
          [],
        ),
      );

      await tabsVM.getRestaurants();

      assert(tabsVM.restaurants.length == 2);
      assert(tabsVM.favoriteRestaurants.isEmpty);
    },
  );

  test(
    'test getRestaurants Success and getFavoriteRestaurantsIds not empty',
    () async {
      SharedPreferences.setMockInitialValues(
        {
          kFavoriteRestaurantsKey: [],
        },
      );

      tabsVM.setYelpRepository(mockYelpRepository);

      when(
        mockYelpRepository.getRestaurants(),
      ).thenAnswer(
        (_) => Future.value(
          RestaurantQueryResult.fromJson(fakeRestaurants),
        ),
      );

      when(
        mockYelpRepository.getFavoriteRestaurantsIds(),
      ).thenAnswer(
        (_) => Future.value(
          ["vHz2RLtfUMVRPFmd7VBEHA"],
        ),
      );

      await tabsVM.getRestaurants();
      print(tabsVM.restaurants.length);

      assert(tabsVM.restaurants.length == 2);
      assert(tabsVM.favoriteRestaurants.isNotEmpty);
    },
  );

  test(
    'test getRestaurants Error',
    () async {
      SharedPreferences.setMockInitialValues(
        {
          kFavoriteRestaurantsKey: [],
        },
      );

      tabsVM.setYelpRepository(mockYelpRepository);

      when(
        mockYelpRepository.getRestaurants(),
      ).thenThrow(
        Exception(),
      );

      when(
        mockYelpRepository.getFavoriteRestaurantsIds(),
      ).thenAnswer(
        (_) => Future.value(
          [],
        ),
      );

      await tabsVM.getRestaurants();
      print(tabsVM.restaurants.length);

      assert(tabsVM.restaurants.isEmpty);
      assert(tabsVM.restaurants.isEmpty);
    },
  );
}

Map<String, dynamic> get fakeRestaurants => {
      "total": 6251,
      "business": [
        {
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
        },
        {
          "id": "faPVqws-x-5k2CQKDNtHxw",
          "name": "Yardbird",
          "price": "\$\$",
          "rating": 4.5,
          "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/xYJaanpF3Dl1OovhmpqAYw/o.jpg",
          ],
          "reviews": [
            {
              "id": "uIeZrx9X1W0XPKqDicXZew",
              "rating": 5,
              "user": {
                "id": "nvcvPpKYpq-nT7wwAexGYw",
                "image_url":
                    "https://s3-media1.fl.yelpcdn.com/photo/2_pHFKGZ3-SlBq_HTXp8wg/o.jpg",
                "name": "Tanner D.",
              },
            },
            {
              "id": "V8KFADRFJnsGUvQ3iRtnig",
              "rating": 5,
              "user": {
                "id": "R_PPnsl0gsIvzhq9JHRCXQ",
                "image_url": null,
                "name": "Misha Z.",
              },
            },
            {
              "id": "NTi315CS824pvOsnqZmnww",
              "rating": 5,
              "user": {
                "id": "swpNJGPBG4XCiMH7FeOUZg",
                "image_url":
                    "https://s3-media2.fl.yelpcdn.com/photo/Tft5UPZtZ4zMNtVgdvbIwQ/o.jpg",
                "name": "Kimberly Z.",
              },
            }
          ],
          "categories": [
            {"title": "Southern", "alias": "southern"},
            {"title": "New American", "alias": "newamerican"},
            {"title": "Cocktail Bars", "alias": "cocktailbars"},
          ],
          "hours": [
            {"is_open_now": true},
          ],
          "location": {
            "formatted_address": "3355 Las Vegas Blvd S\nLas Vegas, NV 89109",
          },
        },
      ],
    };
