import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:sport_app/router/navigation_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initState()) {
    on<ButtonSignOutEvent>(_onButtonSignOut);
  }

  Future<void> _onButtonSignOut(
      ButtonSignOutEvent event, Emitter<void> emitter) async {
    SharedPreferencesHelper.shared.logout();
    NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.login);
    SharedPreferencesHelper.shared.logout();
  }

  static ProfileBloc of(BuildContext context) =>
      BlocProvider.of<ProfileBloc>(context);
}
