import 'package:sport_app/bloc/notification/bloc/notification_event.dart';
import 'package:sport_app/bloc/notification/bloc/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState.initState()) {
    on<UpdateNotificationEvent>(_onUpdateNotification);
  }
  Future<void> _onUpdateNotification(
      UpdateNotificationEvent event, Emitter<void> emitter) async {
    // int? badge =SharedPreferencesHelper.shared.getInt(AppKeyName.badgeCount);
    emitter(state.copyWith(count: 10));
  }

  static NotificationBloc of(BuildContext context) =>
      BlocProvider.of<NotificationBloc>(context);
}
