import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/blocs/blocs.dart';
import 'package:restaurantour/data/data.dart';
import 'package:restaurantour/ui/ui.dart';

import '../../../helpers/helpers.dart';
import '../../../mocks/blocs/mock_restaurants_cubit.dart';
import '../../../mocks/repositories/repositories.dart';
import '../../../mocks/router/mock_go_router.dart';

void main() {
  late RestaurantsCubit cubit;

  setUp(() {
    cubit = MockRestaurantsCubit();
    when(() => cubit.state).thenReturn(RestaurantsState.initial());
  });

  group('HomePage', () {
    Widget buildSubject() {
      return BlocProvider.value(
        value: cubit,
        child: const HomePage(),
      );
    }

    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets(
      'renders a Snackbar '
      'when there is a failure',
      (tester) async {
        whenListen<RestaurantsState>(
          cubit,
          Stream.fromIterable([
            RestaurantsState.initial(),
            RestaurantsState.initial().copyWith(
              failure: optionOf(const RestaurantFailure.unauthorized()),
            ),
          ]),
        );
        await tester.pumpApp(buildSubject());
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      },
    );
  });

  group('HomeView', () {
    late YelpRepository yelpRepository;
    late MockGoRouter navigator;

    setUp(() {
      navigator = MockGoRouter();
      when(() => navigator.pushNamed(any(), extra: any(named: 'extra')))
          .thenAnswer((_) async => {});

      yelpRepository = MockYelpRepository();
      when(
        () => yelpRepository.getRestaurants(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer(
        (_) async =>
            right(const RestaurantQueryResult(total: 0, restaurants: [])),
      );
    });

    Widget buildSubject() {
      return BlocProvider.value(
        value: cubit,
        child: const HomePage(),
      );
    }

    testWidgets(
      'renders AppBar with title text and a bottom TabBar with two title tabs',
      (tester) async {
        await tester.pumpApp(buildSubject());

        expect(find.byType(AppBar), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text(StringValues.title),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.byType(TabBar),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(TabBar),
            matching: find.byType(Tab),
          ),
          findsNWidgets(2),
        );
        expect(
          find.descendant(
            of: find.byType(Tab),
            matching: find.text(StringValues.allRestaurants),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(Tab),
            matching: find.text(StringValues.myFavorites),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders restaurant tab',
      (tester) async {
        const allRestaurantsTab = Key('all_restaurants_tab');

        when(() => cubit.state).thenReturn(
          RestaurantsState.initial().copyWith(isLoading: false),
        );

        await tester.pumpApp(buildSubject());
        expect(find.byKey(allRestaurantsTab), findsOneWidget);
      },
    );
    testWidgets(
      'renders favorites tab '
      'when tapped',
      (tester) async {
        const favoritesTab = Key('favorites_restaurants_tab');

        when(() => cubit.state).thenReturn(
          RestaurantsState.initial().copyWith(isLoading: false),
        );

        await tester.pumpApp(buildSubject());
        await tester.tap(find.text(StringValues.myFavorites));
        await tester.pumpAndSettle();

        expect(find.byKey(favoritesTab), findsOneWidget);
      },
    );

    testWidgets(
      'renders a CircularProgressIndicator '
      'when loading',
      (tester) async {
        when(() => cubit.state)
            .thenReturn(RestaurantsState.initial().copyWith(isLoading: true));

        await tester.pumpApp(buildSubject());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    group('All restaurants tab', () {
      testWidgets(
        'renders an EmptySection '
        'when there are no restaurants',
        (tester) async {
          when(() => cubit.state).thenReturn(
            RestaurantsState.initial().copyWith(isLoading: false),
          );

          await tester.pumpApp(buildSubject());

          expect(find.byType(EmptySection), findsOneWidget);
        },
      );

      group('ListView', () {
        testWidgets(
          'renders an EmptySection with text and icon '
          'when there are no restaurants',
          (tester) async {
            when(() => cubit.state).thenReturn(
              RestaurantsState.initial().copyWith(isLoading: false),
            );

            await tester.pumpApp(buildSubject());

            expect(find.byType(EmptySection), findsOneWidget);
            expect(
              find.descendant(
                of: find.byType(EmptySection),
                matching: find.text(StringValues.emptyRestaurants),
              ),
              findsOneWidget,
            );
            expect(
              find.descendant(
                of: find.byType(EmptySection),
                matching: find.byIcon(Icons.store),
              ),
              findsOneWidget,
            );
          },
        );

        testWidgets(
          'renders RestaurantListTiles '
          'when there are restaurants',
          (tester) async {
            when(() => cubit.state).thenReturn(
              RestaurantsState.initial().copyWith(
                isLoading: false,
                restaurants: [
                  const RestaurantUi(restaurant: Restaurant()),
                ],
              ),
            );

            await tester.pumpApp(buildSubject());

            expect(find.byType(EmptySection), findsNothing);
            expect(find.byType(ListView), findsOneWidget);
            expect(
              find.descendant(
                of: find.byType(ListView),
                matching: find.byType(RestaurantListTile),
              ),
              findsOneWidget,
            );
          },
        );
        testWidgets(
          'navigates to the RestaurantDetailPage '
          'when pressed on a RestaurantListTile',
          (tester) async {
            const restaurant = RestaurantUi(restaurant: Restaurant());

            when(() => cubit.state).thenReturn(
              RestaurantsState.initial().copyWith(
                isLoading: false,
                restaurants: const [restaurant],
              ),
            );
            await tester.pumpApp(
              InheritedGoRouter(goRouter: navigator, child: buildSubject()),
            );

            await tester.tap(find.byType(RestaurantListTile));

            verify(
              () => navigator.pushNamed(
                RouteName.restaurantDetails,
                extra: restaurant,
              ),
            ).called(1);
          },
        );

        group('pagination', () {
          const pagination = Key('allRestaurants_pagination');

          testWidgets(
            'renders view more text and calls getRestaurants '
            'when has more and tapped',
            (tester) async {
              when(() => cubit.state).thenReturn(
                RestaurantsState.initial().copyWith(
                  hasMore: true,
                  isLoading: false,
                  restaurants: [
                    const RestaurantUi(restaurant: Restaurant()),
                  ],
                ),
              );

              when(() => cubit.getRestaurants())
                  .thenAnswer((_) => Future.value());

              await tester.pumpApp(buildSubject());

              expect(find.byKey(pagination), findsOneWidget);
              expect(find.text(StringValues.viewMore), findsOneWidget);

              await tester.tap(find.text(StringValues.viewMore));

              verify(cubit.getRestaurants).called(1);
            },
          );

          testWidgets(
            'renders loading text and not calls getRestaurants '
            'when is loading more and tapped',
            (tester) async {
              when(() => cubit.state).thenReturn(
                RestaurantsState.initial().copyWith(
                  isLoading: false,
                  isLoadingMore: true,
                  restaurants: [
                    const RestaurantUi(restaurant: Restaurant()),
                  ],
                ),
              );

              await tester.pumpApp(buildSubject());

              expect(find.text(StringValues.loading), findsOneWidget);

              await tester.tap(find.text(StringValues.loading));

              verifyNever(cubit.getRestaurants);
            },
          );

          testWidgets(
            'is not rendered '
            'when has more is false',
            (tester) async {
              when(() => cubit.state).thenReturn(
                RestaurantsState.initial().copyWith(
                  hasMore: false,
                  isLoading: false,
                  restaurants: [
                    const RestaurantUi(restaurant: Restaurant()),
                  ],
                ),
              );

              await tester.pumpApp(buildSubject());

              expect(find.byKey(pagination), findsNothing);
            },
          );
        });
      });
    });

    group('favorites tab', () {
      Future<void> openFavoritesTab(WidgetTester tester) async {
        await tester.tap(find.text(StringValues.myFavorites));
        await tester.pumpAndSettle();
      }

      testWidgets(
        'renders an EmptySection '
        'when there are no favorites',
        (tester) async {
          when(() => cubit.state).thenReturn(
            RestaurantsState.initial().copyWith(isLoading: false),
          );

          await tester.pumpApp(buildSubject());
          await openFavoritesTab(tester);

          expect(find.byType(EmptySection), findsOneWidget);
          expect(
            find.descendant(
              of: find.byType(EmptySection),
              matching: find.text(StringValues.emptyFavorites),
            ),
            findsOneWidget,
          );
          expect(
            find.descendant(
              of: find.byType(EmptySection),
              matching: find.byIcon(Icons.favorite_border),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders ListView only with favorites RestaurantListTiles',
        (tester) async {
          when(() => cubit.state).thenReturn(
            RestaurantsState.initial().copyWith(
              isLoading: false,
              restaurants: const [
                RestaurantUi(restaurant: Restaurant(), isFavorite: true),
                RestaurantUi(restaurant: Restaurant()),
              ],
            ),
          );

          await tester.pumpApp(buildSubject());
          await openFavoritesTab(tester);

          expect(find.byType(ListView), findsOneWidget);
          expect(
            find.descendant(
              of: find.byType(ListView),
              matching: find.byType(RestaurantListTile),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'navigates to the RestaurantDetailPage '
        'when pressed on a RestaurantListTile',
        (tester) async {
          const restaurant =
              RestaurantUi(restaurant: Restaurant(), isFavorite: true);

          when(() => cubit.state).thenReturn(
            RestaurantsState.initial().copyWith(
              isLoading: false,
              restaurants: const [restaurant],
            ),
          );
          await tester.pumpApp(
            InheritedGoRouter(goRouter: navigator, child: buildSubject()),
          );

          await openFavoritesTab(tester);

          await tester.tap(find.byType(RestaurantListTile));

          verify(
            () => navigator.pushNamed(
              RouteName.restaurantDetails,
              extra: restaurant,
            ),
          ).called(1);
        },
      );
    });
  });
}
