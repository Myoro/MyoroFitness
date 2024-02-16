// ignore_for_file: curly_braces_in_flow_control_structures

import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/database.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/models/meal.dart";

enum EditFoodEventEnum { edit, delete }

abstract class MealEvent {}
class SetSelectedMealEvent extends MealEvent {
  String meal;
  SetSelectedMealEvent(this.meal);
}
class AddFoodsToMealEvent extends MealEvent {
  List<Food> foods;
  AddFoodsToMealEvent(this.foods);
}
class EditFoodEvent extends MealEvent {
  final Food food;
  final int index;
  final String meal;
  EditFoodEventEnum mode;

  EditFoodEvent({
    required this.food,
    required this.index,
    required this.meal,
    required this.mode
  });
}

class MealState {
  final String? selectedMeal;
  final Meal breakfast;
  final Meal lunch;
  final Meal dinner;
  final Meal snacks;

  MealState({
    this.selectedMeal,
    this.breakfast = const Meal(name: "Breakfast"),
    this.lunch     = const Meal(name: "Lunch"),
    this.dinner    = const Meal(name: "Dinner"),
    this.snacks    = const Meal(name: "Snacks")
  });

  MealState copyWith({
    String? selectedMeal,
    Meal? breakfast,
    Meal? lunch,
    Meal? dinner,
    Meal? snacks
  }) => MealState(
    selectedMeal: selectedMeal ?? this.selectedMeal,
    breakfast: breakfast ?? this.breakfast,
    lunch: lunch ?? this.lunch,
    dinner: dinner ?? this.dinner
  );
}

class MealBloc extends Bloc<MealEvent, MealState> {
  Meal getMeal(String mealName) {
    switch(state.selectedMeal) {
      case "Breakfast": return state.breakfast;
      case "Lunch":     return state.lunch;
      case "Dinner":    return state.dinner;
      case "Snacks":    return state.snacks;
      default:          throw  Exception("MealBloc::getMeal --> This shouldn't ever be executed");
    }
  }

  MealState emitToMeal(String mealName, dynamic emitData) {
    Database().update("meals", "foods", emitData.join(','));

    switch(state.selectedMeal) {
      case "Breakfast": return state.copyWith(breakfast: Meal(name: "Breakfast", foods: emitData));
      case "Lunch":     return state.copyWith(breakfast: Meal(name: "Lunch", foods: emitData));
      case "Dinner":    return state.copyWith(breakfast: Meal(name: "Dinner", foods: emitData));
      case "Snacks":    return state.copyWith(breakfast: Meal(name: "Snacks", foods: emitData));
      default:          throw  Exception("MealBloc::getMeal --> This shouldn't ever be executed");
    }
  }

  MealBloc() : super(MealState()) {
    on<SetSelectedMealEvent>((event, emit) => emit(state.copyWith(selectedMeal: event.meal)));

    on<AddFoodsToMealEvent>((event, emit) => emit(emitToMeal(state.selectedMeal!, [ ...getMeal(state.selectedMeal!).foods, ...event.foods ])));

    on<EditFoodEvent>((event, emit) {
      List<Food> foods = getMeal(event.meal).foods;
      if(event.mode == EditFoodEventEnum.edit) foods[event.index] = event.food;
      else                                     foods.removeAt(event.index);
      emit(emitToMeal(event.meal, foods));
    });
  }
}