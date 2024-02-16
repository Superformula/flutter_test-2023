part of '../main.dart';

final _get = GetIt.I.get;

RestaurantsManager get restaurants => _get<RestaurantsManager>();
FavoritesManager get favorites => _get<FavoritesManager>();
YelpRepository get yelpService => _get<YelpService>();

void registerManagerHandlers({bool testMode = false}) {
  GetIt.I.registerLazySingleton(() => RestaurantsManager());
  GetIt.I.registerLazySingleton(() => FavoritesManager());
  GetIt.I.registerLazySingleton(() => YelpService());

  if (testMode) {
    GetIt.I.pushNewScope();
    GetIt.I.registerLazySingleton(() => RestaurantsManagerMock());
    GetIt.I.registerLazySingleton(() => FavoritesManagerMock());
  }
}
