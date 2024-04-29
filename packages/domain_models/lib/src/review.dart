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
}
