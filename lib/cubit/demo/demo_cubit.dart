import 'package:flutter_bloc/flutter_bloc.dart';

class DemoCubit extends Cubit<int> {
  DemoCubit() : super(10);
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}