import 'package:domain_models/src/user.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String? id;
  final int? rating;
  final String? text;
  final User? user;

  const Review({
    this.id,
    this.rating,
    this.text,
    this.user,
  });

  @override
  List<Object?> get props => [id, rating, text, user];

  @override
  bool? get stringify => true;

  Review copyWith({
    String? id,
    int? rating,
    String? text,
    User? user,
  }) =>
      Review(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        text: text ?? this.text,
        user: user ?? this.user,
      );
}
