import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:restaurantour/core/helpers/hive_helper.dart';
import 'package:restaurantour/core/models/restaurant.dart';
import 'package:restaurantour/features/home_page/presenter/bloc/home_bloc.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class MockHiveHelper extends Mock implements HiveHelper {}

class MockYelpRepository extends Mock implements YelpRepository {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(
      fileName: "test/.env.test",
    );
  });

  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late HiveHelper mockHiveHelper;
    late YelpRepository mockYelpRepository;

    setUp(() {
      mockHiveHelper = MockHiveHelper();
      mockYelpRepository = MockYelpRepository();
      homeBloc = HomeBloc(
        hiveHelper: mockHiveHelper,
        yelpRepository: mockYelpRepository,
      );
    });

    test('initial state is HomeInitial', () {
      expect(homeBloc.state, HomeInitial());
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoadingState, HomeDataLoadedState] when HomeInitialEvent is added',
      build: () {
        when(() => mockHiveHelper.getAllFavoriteIds()).thenReturn(['1', '2']);
        when(() => mockYelpRepository.getRestaurants()).thenAnswer(
          (_) async => const Ok(
            RestaurantQueryResult(
              total: 1,
              restaurants: [
                Restaurant(
                  id: '1',
                  name: 'Fake Restaurant',
                ),
              ],
            ),
          ),
        );

        return homeBloc;
      },
      act: (bloc) => bloc.add(const InitialEvent()),
      expect: () => [
        const HomeLoadingState(),
        isA<HomeDataLoadedState>(),
      ],
    );


    tearDown(() {
      homeBloc.close();
    });
  });
}
