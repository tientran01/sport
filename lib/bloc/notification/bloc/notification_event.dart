import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

class UpdateNotificationEvent extends NotificationEvent {
  final int? count;
  const UpdateNotificationEvent({this.count});
  @override
  List<Object?> get props => [count];
}