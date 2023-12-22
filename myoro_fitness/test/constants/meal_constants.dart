import 'package:myoro_fitness/models/meal.dart';

import 'food_constants.dart';

class MealConstants {
  static final Meal meal = Meal(
    name: "Foo",
    foods: List.generate(5, (index) => FoodConstants.food)
  );
}