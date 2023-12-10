enum Unit {
  gram('g'), milligram('mg'), kcal('cals');
  const Unit(this.unit);
  final String unit;
}

class Nutrient {
  int value;
  Unit? unit;

  Nutrient.fromJson(Map<String, dynamic> json)
    : value = int.parse(json["nutrientNumber"]),
      unit  = _getUnit(json["unitName"]);

  static Unit? _getUnit(String unit) {
    switch(unit) {
      case "KCAL": return Unit.kcal;
      case "G":    return Unit.gram;
      case "MG":   return Unit.milligram;
      default:     return null;
    }
  }
}