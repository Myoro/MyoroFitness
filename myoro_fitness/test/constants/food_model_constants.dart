import 'package:myoro_fitness/enums/unit_enum.dart';
import 'package:myoro_fitness/models/food_model.dart';
import 'package:myoro_fitness/models/nutrient_model.dart';

class FoodModelConstants {
  static FoodModel get foodModel => FoodModel(
    name: 'Food Model Constant Name',
    brand: 'Food Model Constnat Brand',
    calories: NutrientModel(name: 'Energy', value: 500, unit: UnitEnum.grams),
    // TODO: Finish
  );
}