import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/core/utils/constants.dart';
import 'package:restaurantour/core/utils/dependency_injector.dart';
import 'package:restaurantour/main.dart';
import 'package:restaurantour/modules/home/data/models/response_model.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/domain/controllers/home_controller.dart';
import 'package:restaurantour/modules/home/domain/repositories/restaurant_repository_interface.dart';
import 'package:restaurantour/modules/home/domain/stores/favorite_store.dart';

import '../../../mocks/class_mocks.dart';

void main() {
  setUp(() {
    locator.registerLazySingleton<FavoriteStore>(() => FavoriteStoreMock());
    locator.registerSingleton<IRestaurantRepository>(ResturantRepositoryMock());
    locator.registerFactory<HomeController>(
      () => HomeController(locator.get<FavoriteStore>(), locator.get<IRestaurantRepository>()),
    );
  });

  tearDown(() => locator.reset());

  testWidgets('should returns a list of restaurants', (WidgetTester tester) async {
    //Arrange
    const Restaurant restaurantFake = Restaurant(
      id: 'test_id',
      name: 'Test Name',
      reviews: [Review(text: 'Review test 1')],
    );
    when(() => locator.get<FavoriteStore>().getFavorites()).thenAnswer((_) => Future.value());
    when(() => locator.get<FavoriteStore>().restaurantsFavorits).thenReturn(mobx.ObservableList<Restaurant>());
    when(() => locator.get<IRestaurantRepository>().getRestaurants(offset: any(named: 'offset')))
        .thenAnswer((_) => Future.value(ResponseModel(data: [restaurantFake])));

    //Act
    await tester.pumpWidget(const Restaurantour());
    expect(find.byKey(const Key(ConstantsApp.kLoading)), findsOneWidget);
    await tester.pumpAndSettle();

    //Assert
    expect(find.text('RestauranteTour'), findsOneWidget);
    expect(find.byKey(const Key(ConstantsApp.kCustomScrollHomePage)), findsOneWidget);
    expect(find.byKey(const Key('${ConstantsApp.kCardRestaurant}_0')), findsOneWidget);
  });

  testWidgets('shlud returns a empty list of restaurants', (WidgetTester tester) async {
    //Arrange
    when(() => locator.get<FavoriteStore>().getFavorites()).thenAnswer((_) => Future.value());
    when(() => locator.get<FavoriteStore>().restaurantsFavorits).thenReturn(mobx.ObservableList<Restaurant>());
    when(() => locator.get<IRestaurantRepository>().getRestaurants(offset: any(named: 'offset')))
        .thenAnswer((_) => Future.value(ResponseModel(data: [])));

    //Act
    await tester.pumpWidget(const Restaurantour());
    expect(find.byKey(const Key(ConstantsApp.kLoading)), findsOneWidget);
    await tester.pumpAndSettle();

    //Assert
    expect(find.text('RestauranteTour'), findsOneWidget);
    expect(find.byKey(const Key(ConstantsApp.kCustomScrollHomePage)), findsOneWidget);
    expect(find.byKey(const Key('${ConstantsApp.kCardRestaurant}_0')), findsNothing);
    expect(find.text('No restaurants in the moment'), findsOneWidget);
  });

  testWidgets('should returns a widget error', (WidgetTester tester) async {
    //Arrange
    when(() => locator.get<FavoriteStore>().getFavorites()).thenAnswer((_) => Future.value());
    when(() => locator.get<FavoriteStore>().restaurantsFavorits).thenReturn(mobx.ObservableList<Restaurant>());
    when(() => locator.get<IRestaurantRepository>().getRestaurants(offset: any(named: 'offset')))
        .thenAnswer((_) => Future.value(ResponseModel(error: Exception())));

    //Act
    await tester.pumpWidget(const Restaurantour());
    expect(find.byKey(const Key(ConstantsApp.kLoading)), findsOneWidget);
    await tester.pumpAndSettle();

    //Assert
    expect(find.text('RestauranteTour'), findsOneWidget);
    expect(find.byKey(const Key(ConstantsApp.kCustomScrollHomePage)), findsNothing);
    expect(find.byKey(const Key('${ConstantsApp.kCardRestaurant}_0')), findsNothing);
    expect(find.bySubtype<ElevatedButton>(), findsOneWidget);
  });
}
