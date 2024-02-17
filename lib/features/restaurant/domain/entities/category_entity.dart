import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    this.title,
    this.alias,
  });

  final String? alias;
  final String? title;

  @override
  List<Object?> get props => [
        alias,
        title,
      ];
}
