import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:restaurantour/features/restaurant_tour/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/dummy_repository.dart';
import 'package:restaurantour/features/restaurant_tour/repositories/yelp_repository.dart';

class MockYelpRepository extends Mock implements YelpRepository {}

void main() {
  group('restaurant bloc', () {
    // ignore: unused_local_variable
    late RestaurantBloc restaurantBloc;
    late DummyRepository dummyRepository;

    blocTest<RestaurantBloc, RestaurantState>(
      'emits Loaded state when successful.',
      build: () {
        dummyRepository = DummyRepository();
        return restaurantBloc =
            RestaurantBloc(dummyRepository: dummyRepository);
      },
      act: (bloc) async {
        bloc.add(LoadRestaurantsEvent());
      },
      expect: () => [
        RestaurantLoading(),
        RestaurantLoaded(),
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits NotLoaded state when it could not load.',
      build: () {
        dummyRepository = DummyRepository(success: false);
        return restaurantBloc =
            RestaurantBloc(dummyRepository: dummyRepository);
      },
      act: (bloc) async {
        bloc.add(LoadRestaurantsEvent());
      },
      expect: () => [
        RestaurantLoading(),
        RestaurantNotLoaded(),
      ],
    );
  });
}
