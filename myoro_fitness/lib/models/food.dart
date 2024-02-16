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
  final double serving;

  Food({
    required this.name,
    this.company,
    this.calories,
    this.protein,
    this.fat,
    this.carbohydrates,
    this.ingredients,
    this.serving = 1
  });

  Food copyWith({
    String? name,
    String? company,
    Nutrient? calories,
    Nutrient? protein,
    Nutrient? fat,
    Nutrient? carbohydrates,
    Ingredients? ingredients,
    double? serving
  }) => Food(
    name: name ?? this.name,
    company: company ?? this.company,
    calories: calories ?? this.calories,
    protein: protein ?? this.protein,
    fat: fat ?? this.fat,
    carbohydrates: carbohydrates ?? this.carbohydrates,
    ingredients: ingredients ?? this.ingredients,
    serving: serving ?? this.serving
  );

  Food.fromJson(Map<String, dynamic> json)
    : name          = json["name"],
      company       = json["company"],
      calories      = (json["calories"] != null) ? Nutrient.fromJson(json["calories"]) : null,
      protein       = (json["protein"] != null) ? Nutrient.fromJson(json["protein"]) : null,
      fat           = (json["fat"] != null) ? Nutrient.fromJson(json["fat"]) : null,
      carbohydrates = (json["carbohydrates"] != null) ? Nutrient.fromJson(json["carbohydrates"]) : null,
      ingredients   = Ingredients(json["ingredients"]),
      serving       = 1;

  Map<String, dynamic> toJson() => {
    "name":          name,
    "company":       company,
    "calories":      (calories != null) ? calories!.toJson() : null,
    "protein":       (protein != null) ? protein!.toJson() : null,
    "fat":           (fat != null) ? fat!.toJson() : null,
    "carbohydrates": (carbohydrates != null) ? carbohydrates!.toJson() : null,
    "ingredients":   ingredients.toString(),
    "serving":       serving.toString()
  };
}
