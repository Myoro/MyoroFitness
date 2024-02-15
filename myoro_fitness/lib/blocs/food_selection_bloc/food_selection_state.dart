import 'package:myoro_fitness/enums/meal_enum.dart';
import 'package:myoro_fitness/models/food_model.dart';

class FoodSelectionState {
  /// Meal we are adding food to
  final MealEnum? meal;

  /// List of foods searched via API
  final List<FoodModel>? foods;

  FoodSelectionState({this.meal, this.foods = const []});

  FoodSelectionState copyWith({
    MealEnum? meal,
    List<FoodModel>? foods,
  }) =>
      FoodSelectionState(
        meal: meal ?? this.meal,
        foods: foods,
      );
}
