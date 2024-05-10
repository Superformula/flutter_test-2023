import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? imageUrl;

  const User({
    this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  @override
  bool? get stringify => true;
}
