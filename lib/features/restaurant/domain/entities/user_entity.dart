import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.imageUrl,
    this.name,
  });

  final String? id;
  final String? imageUrl;
  final String? name;

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        name,
      ];
}
