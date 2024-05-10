import 'package:domain_models/domain_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/local_storage.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_detail/restaurant_detail.dart';
import 'package:restaurant_list/restaurant_list.dart';
import 'package:restaurantour/start.dart';
import 'package:yelp_repository/yelp_repository.dart';

import 'events/events.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([LocalStorage, YelpRepository])
void main() {
  final yelpRepository = MockYelpRepository();
  final localStorage = MockLocalStorage();
  final restaurants = List.generate(
    21,
    (index) => Restaurant(
      id: 'id_$index',
      name: 'name_$index',
      price: 'price_$index',
      rating: 4.6,
      photoUrl: 'photoUrl_$index',
      category: 'category_$index',
      isOpen: true,
      address: 'address_$index',
    ),
  );

  setUp(() {
    when(yelpRepository.getRestaurants())
        .thenAnswer((_) => Future.value(restaurants));
    when(
      yelpRepository.getReviews(
        restaurantId: anyNamed('restaurantId'),
        offset: anyNamed('offset'),
      ),
    ).thenAnswer((_) => Future.value([]));
    when(localStorage.restaurantListener).thenAnswer((_) => Stream.value([]));
    when(localStorage.containsRestaurantListener(any))
        .thenAnswer((_) => Stream.value(false));
    when(localStorage.addRestaurant(any)).thenReturn(1);
  });

  tearDown(() {
    reset(yelpRepository);
    reset(localStorage);
    resetMockitoState();
  });

  testWidgets('Set restaurant as favorite', (WidgetTester tester) async {
    await tester.pumpWidget(
      Restaurantour(
        yelpRepository: yelpRepository,
        localStorage: localStorage,
      ),
    );

    final restaurantListView = find.byType(RestaurantListView);
    expect(restaurantListView, findsOneWidget);

    await tapOnFavoritesTab(tester);
    await tester.pumpAndSettle();

    final emptyFavoriteImage = find.byKey(emptyFavoritesImageKey);
    expect(emptyFavoriteImage, findsOneWidget);

    await tapOnAllRestaurantsTab(tester);
    await tester.pumpAndSettle();

    await tapFirstRestaurantCard(tester);
    await tester.pumpAndSettle();

    final restaurantDetailView = find.byType(RestaurantDetailView);
    expect(restaurantDetailView, findsOneWidget);

    await tapOnBorderedHeart(tester);
    await tester.pumpAndSettle();
    verify(localStorage.addRestaurant(restaurants.first)).called(1);
  });
}
