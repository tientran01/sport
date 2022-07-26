import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String? displayName;
  const ProfileState({this.displayName});
  ProfileState copyWith({
    String? displayName,
  }) {
    return ProfileState(
      displayName: displayName,
    );
  }

  const ProfileState.initState() : this();
  @override
  List<Object?> get props => [displayName];
}
