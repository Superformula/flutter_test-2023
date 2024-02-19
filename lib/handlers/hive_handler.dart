part of '../main.dart';

void registerHiveHandler() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(HoursAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ReviewAdapter());
  Hive.registerAdapter(LocationAdapter());
  await Hive.openBox<Restaurant>('favorites');
}
