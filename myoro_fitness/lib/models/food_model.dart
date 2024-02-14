import 'package:myoro_fitness/enums/unit_enum.dart';
import 'package:myoro_fitness/helpers/conversion_helper.dart';
import 'package:myoro_fitness/models/nutrient_model.dart';

class FoodModel {
  final String name;
  final String? brand;
  final NutrientModel? calories;
  final NutrientModel? protein;
  final NutrientModel? carbohydrates;
  final NutrientModel? fats;
  final NutrientModel? transFats;
  final NutrientModel? saturatedFats;
  final NutrientModel? sugars;
  final NutrientModel? fibers;
  final NutrientModel? calcium;
  final NutrientModel? iron;
  final NutrientModel? sodium;
  final NutrientModel? vitaminA;
  final NutrientModel? vitaminC;
  final NutrientModel? cholesterol;
  final String? ingredients;

  FoodModel({
    required this.name,
    this.brand,
    this.calories,
    this.protein,
    this.carbohydrates,
    this.fats,
    this.transFats,
    this.saturatedFats,
    this.sugars,
    this.fibers,
    this.calcium,
    this.iron,
    this.sodium,
    this.vitaminA,
    this.vitaminC,
    this.cholesterol,
    this.ingredients,
  });

  static FoodModel fromJSON(Map<String, dynamic> json) {
    NutrientModel? calories;
    NutrientModel? protein;
    NutrientModel? carbohydrates;
    NutrientModel? fats;
    NutrientModel? transFats;
    NutrientModel? saturatedFats;
    NutrientModel? sugars;
    NutrientModel? fibers;
    NutrientModel? calcium;
    NutrientModel? iron;
    NutrientModel? sodium;
    NutrientModel? vitaminA;
    NutrientModel? vitaminC;
    NutrientModel? cholesterol;

    for (final Map<String, dynamic> nutrient in json['foodNutrients']) {
      switch (nutrient['nutrientName']) {
        case 'Energy':
          if (nutrient['unitName'] == 'kJ') break;
          calories = NutrientModel.fromJSON(nutrient);
          break;
        case 'Protein':
          protein = NutrientModel.fromJSON(nutrient);
          break;
        case 'Carbohydrate, by difference':
          carbohydrates = NutrientModel.fromJSON(nutrient);
          break;
        case 'Total lipid (fat)':
          fats = NutrientModel.fromJSON(nutrient);
          break;
        case 'Total sugars':
          sugars = NutrientModel.fromJSON(nutrient);
          break;
        case 'Fiber, total dietary':
          fibers = NutrientModel.fromJSON(nutrient);
          break;
        case 'Calcium, Ca':
          calcium = NutrientModel.fromJSON(nutrient);
          break;
        case 'Iron, Fe':
          iron = NutrientModel.fromJSON(nutrient);
          break;
        case 'Sodium, Na':
          sodium = NutrientModel.fromJSON(nutrient);
          break;
        case 'Vitamin A, UI':
          vitaminA = NutrientModel.fromJSON(nutrient);
          break;
        case 'Vitamin C, total ascorbic acid':
          vitaminC = NutrientModel.fromJSON(nutrient);
          break;
        case 'Cholesterol':
          cholesterol = NutrientModel.fromJSON(nutrient);
          break;
        case 'Fatty acids, total trans':
          transFats = NutrientModel.fromJSON(nutrient);
          break;
        case 'Fatty acids, total saturated':
          saturatedFats = NutrientModel.fromJSON(nutrient);
          break;
      }
    }

    if(calories != null && calories.unit == UnitEnum.kilojoules) {
      calories.value = ConversionHelper.killojoulesToCalories(calories.value);
      calories.unit = UnitEnum.calories;
    }

    return FoodModel(
      name: json['description'],
      brand: json['brandName'] != '' ? json['brandName'] : null,
      calories: calories,
      protein: protein,
      carbohydrates: carbohydrates,
      fats: fats,
      transFats: transFats,
      saturatedFats: saturatedFats,
      sugars: sugars,
      fibers: fibers,
      calcium: calcium,
      iron: iron,
      sodium: sodium,
      vitaminA: vitaminA,
      vitaminC: vitaminC,
      cholesterol: cholesterol,
      ingredients: json['ingredients'],
    );
  }
}
