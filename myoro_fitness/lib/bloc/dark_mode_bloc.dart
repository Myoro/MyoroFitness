import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/database.dart";

abstract class DarkModeEvent {}
class ToggleDarkModeEvent extends DarkModeEvent {}

class DarkModeState {
  final bool enabled;
  DarkModeState(this.enabled);
}

class DarkModeBloc extends Bloc<DarkModeEvent, DarkModeState> {
  DarkModeBloc() : super(DarkModeState(true)) {
    on<ToggleDarkModeEvent>((event, emit) {
      Database().update("dark_mode", "enabled", state.enabled ? 0 : 1);
      emit(DarkModeState(!state.enabled));
    });
  }
}