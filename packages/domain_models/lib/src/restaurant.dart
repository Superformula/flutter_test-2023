import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final String? photoUrl;
  final String? category;
  final bool? isOpen;
  final String? address;

  const Restaurant({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.photoUrl,
    required this.category,
    required this.isOpen,
    required this.address,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        rating,
        photoUrl,
        category,
        isOpen,
        address,
      ];
}
