import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  final int? count;
  const NotificationState({
    this.count,
  });
  const NotificationState.initState() : this();
  NotificationState copyWith({
    int? count,
  }) {
    return NotificationState(
      count: count,
    );
  }

  @override
  List<Object?> get props => [count];
}
