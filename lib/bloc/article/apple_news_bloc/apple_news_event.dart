import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class AppleNewsEvent extends Equatable {
  const AppleNewsEvent();
  @override
  List<Object?> get props => [];
}

class AppleNewsApiEvent extends AppleNewsEvent {
  final List<Article>? articles;
  const AppleNewsApiEvent({this.articles});
  @override
  List<Object?> get props => [articles];
}
