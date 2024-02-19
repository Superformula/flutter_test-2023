import 'package:bloc/bloc.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/domain/usecases/get_reviews_texts.dart';
import 'package:restaurantour/presentation/bloc/reviews_bloc/review_state.dart';
import 'package:restaurantour/presentation/bloc/reviews_bloc/reviews_event.dart';


class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final GetRestaurantReviewsUseCase getRestaurantDetailsUseCase;
  final favList = <RestaurantEntity>[];

  ReviewBloc(this.getRestaurantDetailsUseCase) : super(ReviewEmpty()) {
    on<OnRequestedReviews>(
      (event, emit) async{
        emit(ReviewLoading());
        final result = await getRestaurantDetailsUseCase.execute(id: event.id);
        print(result);
        result.fold((failure) {
          emit(ReviewLoadFail(failure.message));
        }, (data) {
          print(data);
          return emit(ReviewLoaded(data));
        });
      },
    );

   
  }
}
