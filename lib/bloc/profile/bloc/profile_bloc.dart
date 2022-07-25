import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import '../../../helper/shared_preferences_helper.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initState()) {
    on<ButtonSignOutEvent>(_onButtonSignOut);
    on<EditProfileImageEvent>(_onEditProfileImage);
  }
  Future<void> _onButtonSignOut(
      ButtonSignOutEvent event, Emitter<void> emitter) async {
    SharedPreferencesHelper.shared.logout();
    NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.login);
    SharedPreferencesHelper.shared.logout();
  }

  Future<void> _onEditProfileImage(
    EditProfileImageEvent event,
    Emitter<void> emitter,
  ) async {
    User? currentUser = FirebaseHelper.shared.auth.currentUser;
    CollectionReference userCollection =
        FirebaseHelper.firebaseFirestore.collection(AppCollection.users);
    DocumentReference userDocument = userCollection.doc(currentUser?.uid);
    userDocument.update({
      AppFieldName.photoUrl: ""
    });
  }

  static ProfileBloc of(BuildContext context) =>
      BlocProvider.of<ProfileBloc>(context);
}
