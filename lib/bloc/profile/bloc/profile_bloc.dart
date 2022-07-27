import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import '../../../helper/shared_preferences_helper.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initState()) {
    on<ButtonSignOutEvent>(_onButtonSignOut);
    on<GetDisplayNameFromTextFieldEvent>(_onGetDisplayNameFromTextField);
    on<EditDisplayNameEvent>(_onEditDisplayName);
    on<GetUserProfile>(_onGetUser);
  }

  Future<void> _onGetUser(
    GetUserProfile event,
    Emitter<void> emitter,
  ) async {
    UserInformation? user = await FirebaseHelper.shared.getUserByUid();
    Loading.dismiss();
    emitter(state.copyWith(user: user));
  }

  Future<void> _onButtonSignOut(
    ButtonSignOutEvent event,
    Emitter<void> emitter,
  ) async {
    SharedPreferencesHelper.shared.logout();
    NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.login);
  }

  Future<void> _onGetDisplayNameFromTextField(
    GetDisplayNameFromTextFieldEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(displayName: event.displayName));
  }

  Future<void> _onEditDisplayName(
    EditDisplayNameEvent event,
    Emitter<void> emitter,
  ) async {
    FirebaseHelper.shared.updateUser(displayName: state.displayName);
    getIt.get<ProfileBloc>().add(GetUserProfile());
  }

  static ProfileBloc of(BuildContext context) =>
      BlocProvider.of<ProfileBloc>(context);
}
