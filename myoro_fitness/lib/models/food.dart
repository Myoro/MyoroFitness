import "package:myoro_fitness/models/nutrient.dart";

class Food {
  final String name;
  final String? company;
  final Unit? calories;
  final Unit? protein;

  Food.fromJson(Map<String, dynamic> json)
    : name     = json["description"],
      company  = (json["brandName"] != null) ? json["brandName"] : null,
      calories = null,
      protein  = null;
}