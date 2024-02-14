import 'package:myoro_fitness/enums/nutrient_enum.dart';
import 'package:myoro_fitness/models/food_model.dart';

import 'nutrient_model_constants.dart';

class FoodModelConstants {
  static FoodModel get food => FoodModel(
    name: 'Food Model Constant Name',
    brand: 'Food Model Constant Brand',
    calories: NutrientModelConstants.specificNutrient(NutrientEnum.calories),
    protein: NutrientModelConstants.specificNutrient(NutrientEnum.protein),
    carbohydrates: NutrientModelConstants.specificNutrient(NutrientEnum.carbohydrates),
    fats: NutrientModelConstants.specificNutrient(NutrientEnum.fats),
    transFats: NutrientModelConstants.specificNutrient(NutrientEnum.transFats),
    saturatedFats: NutrientModelConstants.specificNutrient(NutrientEnum.saturatedFats),
    sugars: NutrientModelConstants.specificNutrient(NutrientEnum.sugars),
    fibers: NutrientModelConstants.specificNutrient(NutrientEnum.fibers),
    calcium: NutrientModelConstants.specificNutrient(NutrientEnum.calcium),
    iron: NutrientModelConstants.specificNutrient(NutrientEnum.iron),
    sodium: NutrientModelConstants.specificNutrient(NutrientEnum.sodium),
    vitaminA: NutrientModelConstants.specificNutrient(NutrientEnum.vitaminA),
    vitaminC: NutrientModelConstants.specificNutrient(NutrientEnum.vitaminC),
    cholesterol: NutrientModelConstants.specificNutrient(NutrientEnum.cholesterol),
    ingredients: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec quis.',
  );
}