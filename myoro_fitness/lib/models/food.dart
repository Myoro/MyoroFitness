import "package:myoro_fitness/models/ingredients.dart";
import "package:myoro_fitness/models/nutrient.dart";

class Food {
  final String name;
  final String? company;
  final Nutrient? calories;
  final Nutrient? protein;
  final Nutrient? fat;
  final Nutrient? carbohydrates;
  final Ingredients? ingredients;

  Food({
    required this.name,
    this.company,
    this.calories,
    this.protein,
    this.fat,
    this.carbohydrates,
    this.ingredients
  });

  Food.fromJson(Map<String, dynamic> json)
    : name          = json["description"],
      company       = json["brandName"],
      calories      = (json["foodNutrients"].length >= 4) ? Nutrient.fromJson(json["foodNutrients"][3]) : null,
      protein       = (json["foodNutrients"].length > 0)  ? Nutrient.fromJson(json["foodNutrients"][0]) : null,
      fat           = (json["foodNutrients"].length >= 2) ? Nutrient.fromJson(json["foodNutrients"][1]) : null,
      carbohydrates = (json["foodNutrients"].length >= 3) ? Nutrient.fromJson(json["foodNutrients"][2]) : null,
      ingredients   = Ingredients(json["ingredients"]);

  Map<String, dynamic> toJson() => {
    "name":          name,
    "company":       company,
    "calories":      (calories != null) ? calories!.toJson() : null,
    "protein":       (protein != null) ? protein!.toJson() : null,
    "fat":           (fat != null) ? fat!.toJson() : null,
    "carbohydrates": (carbohydrates != null) ? carbohydrates!.toJson() : null,
    "ingredients":   ingredients.toString()
  };
}
