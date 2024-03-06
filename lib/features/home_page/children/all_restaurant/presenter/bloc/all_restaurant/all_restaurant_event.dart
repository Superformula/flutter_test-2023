part of 'all_restaurant_bloc.dart';

abstract class AllRestaurantEvent extends Equatable {
  const AllRestaurantEvent();
}

class IniEvent extends AllRestaurantEvent {
  const IniEvent();

  @override
  List<Object> get props => [];
}