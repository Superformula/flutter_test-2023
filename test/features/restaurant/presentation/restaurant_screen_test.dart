import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/common/widgets/app_error_refresh_widget.dart';
import 'package:restaurantour/features/restaurant/domain/entities/location_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/review_entity.dart';
import 'package:restaurantour/features/restaurant/domain/entities/user_entity.dart';
import 'package:restaurantour/features/restaurant/presentation/cubit/restaurants_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_screen.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/restaurant_item_widget.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/restaurant_list_widget.dart';
import 'package:bloc_test/bloc_test.dart';

class _MockRestaurantsCubit extends MockCubit<RestaurantsState>
    implements RestaurantsCubit {}

void main() {
  late _MockRestaurantsCubit mockRestaurantsCubit;

  const tRestaurant = RestaurantEntity(
    name: "Yardbird Southern Table & Bar",
    price: "\$\$\$",
    photos: [],
    location: LocationEntity(formattedAddress: "Baker Street"),
    rating: 4.5,
    reviews: [
      ReviewEntity(
        rating: 5,
        user: UserEntity(
          name: "Crystal L.",
          imageUrl: "",
        ),
      ),
    ],
  );

  final tLoadedState = RestaurantsLoaded(
    restaurants: const [tRestaurant],
    favoriteRestaurants: const [tRestaurant],
  );

  final tEmptyState = RestaurantsLoaded(
    restaurants: const [],
    favoriteRestaurants: const [],
  );

  final tErrorState = RestaurantsError(
    errorMessage: 'Something went wrong',
  );

  setUpAll(() async {
    registerFallbackValue(tLoadedState);
    registerFallbackValue(tEmptyState);
    registerFallbackValue(tErrorState);
  });

  group('RestaurantScreen tests', () {
    setUp(() {
      mockRestaurantsCubit = _MockRestaurantsCubit();
    });

    testWidgets('All Restaurants list containing only one restaurant is is displayed',
        (WidgetTester tester) async {
      when(() => mockRestaurantsCubit.state).thenAnswer(
        (_) => tLoadedState,
      );

      await tester.pumpWidget(BlocProvider<RestaurantsCubit>(
        create: (_) => mockRestaurantsCubit,
        child: const MaterialApp(
          home: RestaurantsScreen(),
        ),
      ),);
      await tester.pumpAndSettle();

      expect(find.byType(RestaurantItemWidget), findsOneWidget);
    });

    testWidgets('My Favorites list containing only one restaurant is is displayed',
            (WidgetTester tester) async {
          when(() => mockRestaurantsCubit.state).thenAnswer(
                (_) => tLoadedState,
          );

          await tester.pumpWidget(BlocProvider<RestaurantsCubit>(
            create: (_) => mockRestaurantsCubit,
            child: const MaterialApp(
              home: RestaurantsScreen(),
            ),
          ),);
          await tester.tap(find.text(RestaurantsScreen.favoriteRestaurantTabTitle));
          await tester.pumpAndSettle();

          expect(find.byType(RestaurantItemWidget), findsOneWidget);
        });

    testWidgets('A message saying no restaurants were found is displayed',
        (WidgetTester tester) async {
      when(() => mockRestaurantsCubit.state).thenAnswer(
        (_) => tEmptyState,
      );

      await tester.pumpWidget(BlocProvider<RestaurantsCubit>(
        create: (_) => mockRestaurantsCubit,
        child: const MaterialApp(
          home: RestaurantsScreen(),
        ),
      ),);
      await tester.pumpAndSettle();

      expect(find.text(RestaurantListWidget.noRestaurantsText), findsOneWidget);
    });

    testWidgets(
        'A message saying no favorite restaurants were found is displayed',
        (WidgetTester tester) async {
      when(() => mockRestaurantsCubit.state).thenAnswer(
        (_) => tEmptyState,
      );

      await tester.pumpWidget(
        BlocProvider<RestaurantsCubit>(
          create: (_) => mockRestaurantsCubit,
          child: const MaterialApp(
            home: RestaurantsScreen(),
          ),
        ),
      );
      await tester.tap(find.text(RestaurantsScreen.favoriteRestaurantTabTitle));
      await tester.pumpAndSettle();

      expect(
        find.text(RestaurantListWidget.noFavoriteRestaurantsText),
        findsOneWidget,
      );
    });

    testWidgets(
        'A widget displaying a error message and a button to refresh the screen is displayed',
        (WidgetTester tester) async {
      when(() => mockRestaurantsCubit.state).thenAnswer(
        (_) => tErrorState,
      );

      await tester.pumpWidget(BlocProvider<RestaurantsCubit>(
        create: (_) => mockRestaurantsCubit,
        child: const MaterialApp(
          home: RestaurantsScreen(),
        ),
      ),);
      await tester.pumpAndSettle();

      expect(find.byType(AppErrorRefreshWidget), findsOneWidget);
    });
  });
}
