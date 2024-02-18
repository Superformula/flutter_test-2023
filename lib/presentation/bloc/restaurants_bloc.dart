import 'package:bloc/bloc.dart';
import 'package:restaurantour/domain/usecases/get_restaurants.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final GetRestaurantsUseCase getRestaurantsUseCase;

  RestaurantsBloc(this.getRestaurantsUseCase) : super(RestaurantsEmpty()) {
    on<OnRequestedRestaurants>(
      (event, emit) async{
        emit(RestaurantsLoading());
        final result = await getRestaurantsUseCase.execute();
        result.fold((failure) {
          emit(RestaurantsLoadFail(failure.message));
        }, (data) {
          return emit(RestaurantsLoaded(data));
        });
      },
    );
  }
}
