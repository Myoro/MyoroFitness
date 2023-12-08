class Food {
  final String name;
  final String? company;
  final int? calories;

  Food.fromJson(Map<String, dynamic> json)
    : name     = json["description"],
      company  = (json["brandName"] != null) ? json["brandName"] : null,
      calories = (json["foodNutrients"][3]["nutrientNumber"] != null) ? int.parse(json["foodNutrients"][3]["nutrientNumber"]) : null;
}