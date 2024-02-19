import 'package:bloc/bloc.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/usecases/get_restaurant_details.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_event.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_state.dart';


class RestaurantDetailsBloc extends Bloc<RestaurantDetailsEvent, RestaurantDetailsState> {
  final GetRestaurantDetailsUseCase getRestaurantDetailsUseCase;
  final favList = <RestaurantEntity>[];

  RestaurantDetailsBloc(this.getRestaurantDetailsUseCase) : super(RestaurantDetailsEmpty()) {
    on<OnRequestedRestaurantDetails>(
      (event, emit) async{
        emit(RestaurantDetailsLoading());
        final result = await getRestaurantDetailsUseCase.execute(id: event.id);
        print(result);
        result.fold((failure) {
          emit(RestaurantDetailsLoadFail(failure.message));
        }, (data) {
          print(data);
          return emit(RestaurantDetailsLoaded(data));
        });
      },
    );
  }
}
