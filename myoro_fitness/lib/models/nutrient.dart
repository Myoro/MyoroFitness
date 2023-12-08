enum Unit { GRAM, MILLIGRAM, KCAL }

class Nutrient {
  int value;
  Unit unit;

  Nutrient.fromJson(Map<String, dynamic> json)
    : value = json["nutrientNumber"] ? json["nutrientNumber"] : null,
      unit  = json["unitName"] ? json["unitName"].toLowerCase() : null;
}