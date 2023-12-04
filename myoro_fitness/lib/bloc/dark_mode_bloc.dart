import "package:flutter_bloc/flutter_bloc.dart";

abstract class DarkModeEvent {}
class ToggleDarkModeEvent extends DarkModeEvent {}

class DarkModeState {
  final bool enabled;
  DarkModeState(this.enabled);
}

class DarkModeBloc extends Bloc<DarkModeEvent, DarkModeState> {
  DarkModeBloc() : super(DarkModeState(true)) {
    on<ToggleDarkModeEvent>((event, emit) {
      emit(DarkModeState(!state.enabled));
    });
  }
}