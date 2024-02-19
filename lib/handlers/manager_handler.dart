part of '../main.dart';

final _get = GetIt.I.get;

RestaurantsManager get rManager => _get<RestaurantsManager>();
FavoritesManager get fManager => _get<FavoritesManager>();
YelpService get yService => _get<YelpService>();
RouterService get rService => _get<RouterService>();

void registerManagerHandlers({bool testMode = false}) {
  GetIt.I.registerLazySingleton(() => RestaurantsManager());
  GetIt.I.registerLazySingleton(() => FavoritesManager());
  GetIt.I.registerLazySingleton(() => YelpService());
  GetIt.I.registerLazySingleton(() => RouterService());

  if (testMode) {
    GetIt.I.pushNewScope();
    GetIt.I.registerLazySingleton(() => RestaurantsManagerMock());
    GetIt.I.registerLazySingleton(() => FavoritesManagerMock());
  }
}
