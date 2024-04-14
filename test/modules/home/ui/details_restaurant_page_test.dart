import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/core/utils/constants.dart';
import 'package:restaurantour/core/utils/dependency_injector.dart';
import 'package:restaurantour/modules/home/data/models/response_model.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/domain/controllers/details_restaurant_controller.dart';
import 'package:restaurantour/modules/home/domain/repositories/restaurant_repository_interface.dart';
import 'package:restaurantour/modules/home/domain/stores/favorite_store.dart';
import 'package:restaurantour/modules/home/ui/details_restaurant_page.dart';

import '../../../mocks/class_mocks.dart';

void main() {
  setUp(() {
    locator.registerLazySingleton<FavoriteStore>(() => FavoriteStoreMock());
    locator.registerSingleton<IRestaurantRepository>(ResturantRepositoryMock());
    locator.registerFactory<DetailsRestaurantController>(
      () => DetailsRestaurantController(locator.get<IRestaurantRepository>()),
    );
  });

  tearDown(() => locator.reset());

  testWidgets('should show details of restaurant', (WidgetTester tester) async {
    //Arrange
    const Restaurant restaurantFake = Restaurant(
      id: 'test_id',
      name: 'Test Name',
      reviews: [Review(text: 'Review test 1')],
    );
    when(() => locator.get<FavoriteStore>().restaurantsFavorits).thenReturn(mobx.ObservableList<Restaurant>());
    when(() => locator.get<IRestaurantRepository>().getRestaurantById(id: any(named: 'id')))
        .thenAnswer((_) => Future.value(ResponseModel(data: restaurantFake)));

    //Act
    await tester.pumpWidget(const MaterialApp(home: DetailsRestaurantPage(restaurant: restaurantFake)));
    final finderTextTitle = find.byKey(const Key(ConstantsApp.kTitleDetailsRestaurant));
    final widgetBefore = tester.widget<Text>(finderTextTitle);
    expect(finderTextTitle, findsOneWidget);
    expect(widgetBefore.data?.isEmpty, true);
    expect(find.byKey(const Key(ConstantsApp.kLoading)), findsOneWidget);
    await tester.pumpAndSettle();

    //Assert
    expect(find.byKey(const Key(ConstantsApp.kErrorDetailsRestaurant)), findsNothing);
    expect(finderTextTitle, findsOneWidget);
    final widgetAfter = tester.widget<Text>(finderTextTitle);
    expect(find.byKey(const Key('${ConstantsApp.kReviewsRestaurant}_0')), findsOneWidget);
    expect(widgetAfter.data, restaurantFake.name);
  });

  testWidgets('should show widget of error when was not found restaurant', (WidgetTester tester) async {
    //Arrange
    when(() => locator.get<FavoriteStore>().restaurantsFavorits).thenReturn(mobx.ObservableList<Restaurant>());

    //Act
    await tester.pumpWidget(const MaterialApp(home: DetailsRestaurantPage(restaurant: Restaurant())));

    await tester.pumpAndSettle();

    //Assert
    expect(find.byKey(const Key(ConstantsApp.kErrorDetailsRestaurant)), findsOneWidget);
  });
}
