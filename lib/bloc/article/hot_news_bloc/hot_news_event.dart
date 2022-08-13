import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class HotNewsEvent extends Equatable {
  const HotNewsEvent();
  @override
  List<Object?> get props => [];
}

class HotNewsLoadApiEvent extends HotNewsEvent {
  final List<Article>? article;
  const HotNewsLoadApiEvent({this.article});
  @override
  List<Object?> get props => [article];
}