import "package:flutter_bloc/flutter_bloc.dart";

abstract class TDEEEvent<T> {}
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
class GetTDEEGenderEvent extends TDEEEvent {
  final String gender;
  GetTDEEGenderEvent(this.gender);
}
class GetTDEEAgeEvent extends TDEEEvent {
  final int age;
  GetTDEEAgeEvent(this.age);
}
class CalculateTDEEEvent extends TDEEEvent {}
class CalculateCalorieDeficitEvent extends TDEEEvent {
  int tdee;
  int deficit;
  CalculateCalorieDeficitEvent(this.tdee, this.deficit);
}

class TDEEState {
  int? height;
  int? weight;
  int? age;
  double? lifestyle;
  String gender;
  int? calorieDeficit;

  TDEEState({
    this.height = 129,
    this.weight,
    this.lifestyle = 1.2,
    this.age,
    this.gender = "Man",
    this.calorieDeficit,
  });

  TDEEState copyWith({
    int? height,
    int? weight,
    double? lifestyle,
    int? age,
    String? gender,
    int? calorieDeficit,
  }) => TDEEState(
    height: height ?? this.height,
    weight: weight ?? this.weight,
    lifestyle: lifestyle ?? this.lifestyle,
    age: age ?? this.age,
    gender: gender ?? this.gender,
    calorieDeficit: calorieDeficit ?? this.calorieDeficit,
  );

  bool tdeeIsCalculable() {
    if(height != null && weight != null && age != null && lifestyle != null) {
      return true;
    } else {
      return false;
    }
  }

  int calculateTDEE() {
    // BMR
      // Males: 88.362 + (13.397 * <weight (kg)>) + (4.799 * <height (cm)>) - (5.677 * age)
      // Females: 447.593 + (9.247 * <weight (kg)>) + (3.098 * <height (cm)>) - (4.330 * age)
    // TDEE: BMR + <lifestyle variable>

    int bmr;
    if(gender == "Male") {
      bmr = (88.362 + (13.397 * weight!) + (4.799 * height!) - (5.677 * age!)).round();
    } else {
      bmr = (447.593 + (9.247 * weight!) + (3.098 * height!) - (4.330 * age!)).round();
    }

    return (bmr * lifestyle!).round();
  }
}

class TDEEBloc extends Bloc<TDEEEvent, TDEEState> {
  TDEEBloc() : super(TDEEState()) {
    on<GetTDEEHeightEvent>((event, emit) => emit(state.copyWith(height: event.height)));
    on<GetTDEEWeightEvent>((event, emit) => emit(state.copyWith(weight: event.weight)));
    on<GetTDEELifestyleEvent>((event, emit) => emit(state.copyWith(lifestyle: event.lifestyle)));
    on<GetTDEEAgeEvent>((event, emit) => emit(state.copyWith(age: event.age)));
    on<GetTDEEGenderEvent>((event, emit) => emit(state.copyWith(gender: event.gender)));
    on<CalculateCalorieDeficitEvent>((event, emit) => emit(state.copyWith(calorieDeficit: event.tdee - event.deficit)));
  }
}