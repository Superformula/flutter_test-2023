import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/features/restaurant_details/restaurant_details_view_model.dart';
import 'package:restaurantour/services/favorites_service.dart';

import '../../mocks/mocks.dart';

void main() {
  FavoritesService favoritesService = FavoritesServiceMock();
  setUp(() {
    GetIt.I.registerFactory<FavoritesService>(() => favoritesService);
    GetIt.I.registerFactory<RTImageNetwork>(() => RTImageNetworkMock());
  });

  tearDown(() {
    reset(favoritesService);
    GetIt.I.reset();
  });
  const String restaurantId = '';
  test('''when [RestaurantDetailsViewModel] is created 
  the [status] should starts with [RestaurantDetailsStatus.loading]
  and no call to [favoritesService.loadFavorites] should be triggered''', () async {
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    expect(sut.status, RestaurantDetailsStatus.loading);
    verifyNever(() => favoritesService.loadFavorites());
  });

  test('when [load] is called should call once time the [loadFavorites] on [FavoritesService]', () async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    await sut.load();

    verify(() => favoritesService.loadFavorites()).called(1);
  });

  test('''when [load] get successfully the data from favoriteService 
  the [status] should be [RestaurantDetailsStatus.content]''', () async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([]));
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    await sut.load();

    expect(sut.status, RestaurantDetailsStatus.content);
  });

  test('when [load] get some error from favoriteService the [status] should be [RestaurantDetailsStatus.error]', () async {
    when(() => favoritesService.loadFavorites()).thenThrow('error mock');
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    await sut.load();

    expect(sut.status, RestaurantDetailsStatus.error);
  });

  test('''when [load] get successfully the data from favoriteService and finds a matching ID in the favorite list 
  [restaurantDetailsViewModel.isFavorite] should be [true]''', () async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([restaurantId]));
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    await sut.load();

    expect(sut.isFavorite, true);
  });

  test('''when [load] get successfully the data from favoriteService and finds no matching ID in the favorite list 
  [restaurantDetailsViewModel.isFavorite] should be [false]''', () async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value(['new-restaurant']));
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    await sut.load();

    expect(sut.isFavorite, false);
  });

  test('''when [load] get successfully the data from favoriteService and the [Restaurant] is favorite and
  when [toggleFavorite] is called should call [favoritesService.removeFavorite] once time
  and [restaurantDetailsViewModel.isFavorite] should be changed to [false]''', () async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value([restaurantId]));
    when(() => favoritesService.addFavorite(any())).thenAnswer((_) => Future.value());
    when(() => favoritesService.removeFavorite(any())).thenAnswer((_) => Future.value());
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    await sut.load();
    expect(sut.isFavorite, true);

    await sut.toggleFavorite();

    expect(sut.isFavorite, false);
    verify(() => favoritesService.removeFavorite(restaurantId)).called(1);
    verifyNever(() => favoritesService.addFavorite(restaurantId));
  });

  test('''when [load] get successfully the data from favoriteService and the [Restaurant] is not favorite and
  when [toggleFavorite] is called should call [favoritesService.addFavorite] once time
  and [restaurantDetailsViewModel.isFavorite] should be changed to [true]''', () async {
    when(() => favoritesService.loadFavorites()).thenAnswer((_) => Future.value(['favorite-restaurant']));
    when(() => favoritesService.addFavorite(any())).thenAnswer((_) => Future.value());
    when(() => favoritesService.removeFavorite(any())).thenAnswer((_) => Future.value());
    final sut = RestaurantDetailsViewModel(favoriteService: favoritesService, restaurantId: restaurantId);

    await sut.load();
    expect(sut.isFavorite, false);

    await sut.toggleFavorite();

    expect(sut.isFavorite, true);
    verify(() => favoritesService.addFavorite(restaurantId)).called(1);
    verifyNever(() => favoritesService.removeFavorite(restaurantId));
  });
}
