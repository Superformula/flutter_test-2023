import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/details/favorite_cubit.dart';
import 'package:restaurantour/presentation/details/restaurant_details.dart';
import 'package:restaurantour/presentation/details/restaurant_details_cubit.dart';
import 'package:restaurantour/presentation/list/favorite_restaurants_cubit.dart';

class MockFavoriteCubit extends Mock implements FavoriteCubit {
  @override
  Future<void> close() async {}
}

class MockFavoriteRestaurantsCubit extends Mock
    implements FavoriteRestaurantsCubit {
  @override
  Future<void> close() async {}
}

void main() {
  late MockFavoriteCubit favoriteCubit;

  late MockFavoriteRestaurantsCubit favoriteRestaurantsCubit;

  setUp(() {
    favoriteCubit = MockFavoriteCubit();
    favoriteRestaurantsCubit = MockFavoriteRestaurantsCubit();
  });

  testWidgets('Icon changes when favorite', (WidgetTester tester) async {
    const restaurant = Restaurant();

    final testWidget = MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<FavoriteCubit>(
            create: (_) => favoriteCubit,
          ),
          BlocProvider<FavoriteRestaurantsCubit>(
            create: (_) => favoriteRestaurantsCubit,
          ),
          BlocProvider<RestaurantDetailsCubit>(
            create: (_) => RestaurantDetailsCubit(restaurant),
          ),
        ],
        child: const RestaurantDetails(),
      ),
    );

    when(() => favoriteRestaurantsCubit.stream).thenAnswer(
      (_) => const Stream.empty(),
    );

    final favoriteStream = StreamController<bool>.broadcast();
    final favoriteState = [false, true];
    when(() => favoriteCubit.stream).thenAnswer((_) => favoriteStream.stream);
    when(() => favoriteCubit.state).thenReturn(favoriteState.removeAt(0));

    favoriteStream.add(false);

    await mockNetworkImages(() async => tester.pumpWidget(testWidget));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    favoriteStream.add(true);
    await tester.pumpAndSettle();

    verify(() => favoriteCubit.setFavorite()).called(1);

    verify(() => favoriteRestaurantsCubit.updateFavoriteRestaurant(restaurant))
        .called(1);

    expect(find.byIcon(Icons.favorite_border), findsNothing);

    expect(find.byIcon(Icons.favorite), findsOneWidget);

    favoriteStream.close();
  });
}
