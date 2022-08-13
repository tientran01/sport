import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class MostInterestedNewsEvent extends Equatable {
  const MostInterestedNewsEvent();
  @override
  List<Object?> get props => [];
}

class MostInterestedNewsApiEvent extends MostInterestedNewsEvent {
  final List<Article>? article;
  const MostInterestedNewsApiEvent({this.article});
  @override
  List<Object?> get props => [article];
}
