import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable{
  
  const CategoryEntity({required this.title,required this.alias});
  
  final String title;
  final String alias;
  
  @override
  List<Object?> get props => [];

}