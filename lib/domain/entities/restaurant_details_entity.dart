import 'package:equatable/equatable.dart';

class RestaurantDetailsEntity extends Equatable {
  const RestaurantDetailsEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
  });

  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewCount;

  @override
  List<Object?> get props => [];
}
