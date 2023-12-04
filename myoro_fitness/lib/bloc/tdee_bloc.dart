import "package:flutter_bloc/flutter_bloc.dart";

abstract class TDEEEvent {}
class GetTDEEHeightEvent extends TDEEEvent {
  final int height;
  GetTDEEHeightEvent(this.height);
}
class GetTDEEWeightEvent extends TDEEEvent {
  final int weight;
  GetTDEEWeightEvent(this.weight);
}
class GetTDEELifestyleEvent extends TDEEEvent {
  final double lifestyle;
  GetTDEELifestyleEvent(this.lifestyle);
}

class TDEEState {
  int? height;
  int? weight;
  double? lifestyle;

  TDEEState({ this.height, this.weight, this.lifestyle });
}

class TDEEBloc extends Bloc<TDEEEvent, TDEEState> {
  TDEEBloc() : super(TDEEState()) {
    on<GetTDEEHeightEvent>((event, emit) => emit(TDEEState(height: event.height)));
    on<GetTDEEWeightEvent>((event, emit) => emit(TDEEState(weight: event.weight)));
    on<GetTDEELifestyleEvent>((event, emit) => emit(TDEEState(lifestyle: event.lifestyle)));
  }
}