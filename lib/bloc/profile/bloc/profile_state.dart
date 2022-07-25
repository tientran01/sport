import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String? photoUrl;
  const ProfileState({this.photoUrl});
  ProfileState copyWith({
    String? photoUrl,
  }) {
    return ProfileState(
      photoUrl: photoUrl,
    );
  }

  const ProfileState.initState() : this();
  @override
  List<Object?> get props => [];
}
