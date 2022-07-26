import 'package:equatable/equatable.dart';
import 'package:sport_app/model/users.dart';

class ProfileState extends Equatable {
  final String? displayName;
  final UserInformation? user;
  const ProfileState({
    this.displayName,
    this.user,
  });

  ProfileState copyWith({
    String? displayName,
    UserInformation? user,
  }) {
    return ProfileState(displayName: displayName, user: user);
  }

  const ProfileState.initState() : this();
  @override
  List<Object?> get props => [displayName, user];
}
