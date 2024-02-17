part of 'all_restaurant_bloc.dart';

abstract class AllRestaurantState extends Equatable {
  const AllRestaurantState();
}

class AllRestaurantInitial extends AllRestaurantState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AllRestaurantState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class DataLoadedState extends AllRestaurantState {
  const DataLoadedState({required this.restaurantList});

  final List<Restaurant> restaurantList;

  @override
  List<Object> get props => [];
}

class EmptyDataState extends AllRestaurantState {
  const EmptyDataState();

  @override
  List<Object> get props => [];
}

class ErrorState extends AllRestaurantState {
  const ErrorState({required this.error});

  final String error;

  @override
  List<Object> get props => [];
}
