import 'package:myoro_fitness/enums/meal_enum.dart';

abstract class FoodSelectionEvent {
  const FoodSelectionEvent();
}

class SetFoodsEvent extends FoodSelectionEvent {
  final String query;
  const SetFoodsEvent(this.query);
}

class SetMealEvent extends FoodSelectionEvent {
  final MealEnum meal;
  const SetMealEvent(this.meal);
}
