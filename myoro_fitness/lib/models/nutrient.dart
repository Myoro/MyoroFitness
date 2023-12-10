enum Unit {
  gram('g'), milligram('mg'), kcal('cals');
  const Unit(this.unit);
  final String unit;
}

class Nutrient {
  final int value;
  final Unit? unit;

  Nutrient({ required this.value, this.unit });

  Nutrient.fromJson(Map<String, dynamic> json)
    : value = int.parse(json["nutrientNumber"]),
      unit  = getUnit(json["unitName"]);

  Map<String, dynamic> toJson() => {
    "value": value,
    "unit":  (unit != null) ? unit!.unit : null
  };

  static Unit? getUnit(String unit) {
    switch(unit) {
      case "KCAL": return Unit.kcal;
      case "G":    return Unit.gram;
      case "MG":   return Unit.milligram;
      default:     return null;
    }
  }
}