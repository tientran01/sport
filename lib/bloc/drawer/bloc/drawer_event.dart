import 'package:equatable/equatable.dart';

abstract class DrawerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ButtonProfileEvent extends DrawerEvent {}