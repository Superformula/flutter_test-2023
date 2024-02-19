import 'package:equatable/equatable.dart';


abstract class RestaurantDetailsEvent extends Equatable{
  const RestaurantDetailsEvent();

  @override
  List<Object?> get props=> [];
}

class OnRequestedRestaurantDetails extends RestaurantDetailsEvent{
  final String id;
  const OnRequestedRestaurantDetails(this.id);
  
  @override
  List<Object?> get props => [];
}

