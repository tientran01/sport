import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ButtonSignOutEvent extends ProfileEvent {}

class GetDisplayNameFromTextFieldEvent extends ProfileEvent {
  final String? displayName;
  GetDisplayNameFromTextFieldEvent({this.displayName});
  @override
  List<Object?> get props => [displayName];
}

class EditDisplayNameEvent extends ProfileEvent {}

class GetUserProfileEvent extends ProfileEvent {}

class DeleteAccountEvent extends ProfileEvent {}
