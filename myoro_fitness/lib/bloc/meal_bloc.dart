import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/models/food.dart";

abstract class MealEvent {}
class AddFoodsToMealEvent extends MealEvent {
  List<Food> foods;
  AddFoodsToMealEvent(this.foods);
}
class SetMealEvent extends MealEvent {
  final String meal;
  SetMealEvent(this.meal);
}

class MealState {
  final String? meal; // Which meal we are editting
  final List<Food> foods;

  MealState({
    this.meal,
    this.foods = const []
  });

  MealState copyWith({
    String? meal,
    List<Food>? foods
  }) => MealState(
    meal: meal ?? this.meal,
    foods: foods ?? this.foods
  );
}

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealState()) {
    on<AddFoodsToMealEvent>((event, emit) => emit(state.copyWith(foods: event.foods)));
    on<SetMealEvent>((event, emit) => emit(MealState(meal: event.meal)));
  }
}