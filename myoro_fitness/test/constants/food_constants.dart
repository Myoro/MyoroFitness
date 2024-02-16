import 'package:myoro_fitness/models/food.dart';
import 'package:myoro_fitness/models/ingredients.dart';
import 'package:myoro_fitness/models/nutrient.dart';

class FoodConstants {
  static final Food food = Food(
    name:          "Foo",
    company:       "Foo Company",
    calories:      Nutrient(value: 100, unit: Unit.kcal),
    protein:       Nutrient(value: 200, unit: Unit.gram),
    fat:           Nutrient(value: 300, unit: Unit.gram),
    carbohydrates: Nutrient(value: 400, unit: Unit.milligram),
    ingredients:   Ingredients("Foo ingredient"),
    serving:       2.5
  );
}