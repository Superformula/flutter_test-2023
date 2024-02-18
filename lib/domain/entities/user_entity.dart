import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  const UserEntity({
    required this.id,
    required this.imageUrl,
    required this.name,

  });

  final String id;
  final String imageUrl;
  final String name;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}