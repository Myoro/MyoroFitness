import 'package:myoro_fitness/models/food_model.dart';

class FoodSelectionState {
  final List<FoodModel>? foods;

  FoodSelectionState({this.foods = const []});

  FoodSelectionState copyWith({
    List<FoodModel>? foods,
  }) =>
      FoodSelectionState(
        foods: foods,
      );
}
