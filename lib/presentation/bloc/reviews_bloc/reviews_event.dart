import 'package:equatable/equatable.dart';


abstract class ReviewEvent extends Equatable{
  const ReviewEvent();

  @override
  List<Object?> get props=> [];
}

class OnRequestedReviews extends ReviewEvent{
  final String id;
  const OnRequestedReviews(this.id);
  
  @override
  List<Object?> get props => [];
}

