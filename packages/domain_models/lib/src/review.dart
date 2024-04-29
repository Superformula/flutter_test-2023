import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final int rating;
  final String text;

  const Review({
    required this.id,
    required this.rating,
    required this.text,
  });

  @override
  List<Object?> get props => [id, rating, text];
}
