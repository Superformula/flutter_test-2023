import 'package:restaurantour/components/rt_image_network.dart';
import 'package:restaurantour/core/core.dart';
import 'package:restaurantour/features/details/details_view_model.dart';
import 'package:restaurantour/models/dto.dart';
import 'package:restaurantour/repositories/restaurant_repository.dart';
import 'package:restaurantour/services/event_bus_service.dart';
import 'package:restaurantour/services/favorite_service.dart';

import '../../test.dart';

void main() {
  FavoriteService favoritesService = FavoritesServiceMock();
  RestaurantRepository restaurantRepository = RestaurantRepositoryMock();
  EventBusService eventBusService = EventBusServiceMock();

  setUp(() {
    GetIt.I.registerFactory<FavoriteService>(() => favoritesService);
    GetIt.I.registerFactory<RestaurantRepository>(() => restaurantRepository);
    GetIt.I.registerFactory<RTImageNetwork>(() => RTImageNetworkMock());
  });

  tearDown(() {
    reset(favoritesService);
    GetIt.I.reset();
  });
  const String restaurantId = '';
  test('''when [DetailsViewModel] is created 
  the [status] should starts with [DetailsStatus.loading]
  and no call to [favoritesService.loadFavorites] should be triggered''', () async {
    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );

    expect(sut.status, DetailsStatus.loading);
    verifyNever(() => favoritesService.getFavorites());
  });

  test('when [load] is called should call once time the [loadFavorites] on [FavoritesService]', () async {
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));
    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );

    await sut.load();

    verify(() => favoritesService.getFavorites()).called(1);
  });

  test('''when [load] get successfully the data from favoriteService 
  the [status] should be [DetailsStatus.content]''', () async {
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([]));
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));
    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );

    await sut.load();

    expect(sut.status, DetailsStatus.content);
  });

  test('when [load] get some error from favoriteService the [status] should be [DetailsStatus.error]', () async {
    when(() => favoritesService.getFavorites()).thenThrow('error mock');
    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));

    await sut.load();

    expect(sut.status, DetailsStatus.error);
  });

  test('''when [load] get successfully the data from favoriteService and finds a matching ID in the favorite list 
  [detailsViewModel.isFavorite] should be [true]''', () async {
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([restaurantId]));
    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));

    await sut.load();

    expect(sut.isFavorite, true);
  });

  test('''when [load] get successfully the data from favoriteService and finds no matching ID in the favorite list 
  [detailsViewModel.isFavorite] should be [false]''', () async {
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value(['new-restaurant']));
    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );

    await sut.load();

    expect(sut.isFavorite, false);
  });

  test('''when [load] get successfully the data from favoriteService and the [Restaurant] is favorite and
  when [toggleFavorite] is called should call [favoritesService.removeFavorite] once time
  and [detailsViewModel.isFavorite] should be changed to [false]''', () async {
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value([restaurantId]));
    when(() => favoritesService.addFavorite(any())).thenAnswer((_) => Future.value());
    when(() => favoritesService.removeFavorite(any())).thenAnswer((_) => Future.value());
    when(() => restaurantRepository.getRestaurantDetails(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(RestaurantDto.fixture()));
    when(() => restaurantRepository.getReviews(restaurantId: any(named: 'restaurantId'))).thenAnswer((_) => Future.value(ReviewQueryResultDto.fixture()));

    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );

    await sut.load();
    expect(sut.isFavorite, true);

    await sut.toggleFavorite();

    expect(sut.isFavorite, false);
    verify(() => favoritesService.removeFavorite(restaurantId)).called(1);
    verifyNever(() => favoritesService.addFavorite(restaurantId));
  });

  test('''when [load] get successfully the data from favoriteService and the [Restaurant] is not favorite and
  when [toggleFavorite] is called should call [favoritesService.addFavorite] once time
  and [detailsViewModel.isFavorite] should be changed to [true]''', () async {
    when(() => favoritesService.getFavorites()).thenAnswer((_) => Future.value(['favorite-restaurant']));
    when(() => favoritesService.addFavorite(any())).thenAnswer((_) => Future.value());
    when(() => favoritesService.removeFavorite(any())).thenAnswer((_) => Future.value());
    final sut = DetailsViewModel(
      favoriteService: favoritesService,
      restaurantId: restaurantId,
      restaurantRepository: restaurantRepository,
      eventBus: eventBusService,
    );

    await sut.load();
    expect(sut.isFavorite, false);

    await sut.toggleFavorite();

    expect(sut.isFavorite, true);
    verify(() => favoritesService.addFavorite(restaurantId)).called(1);
    verifyNever(() => favoritesService.removeFavorite(restaurantId));
  });
}
