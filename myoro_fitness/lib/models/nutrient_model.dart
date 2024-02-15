import 'package:myoro_fitness/enums/nutrient_enum.dart';
import 'package:myoro_fitness/enums/unit_enum.dart';

class NutrientModel {
  final String name;
  final double value;
  final UnitEnum? unit;

  NutrientModel({
    required this.name,
    required this.value,
    this.unit,
  });

  set value(double value) => this.value = value;
  set unit(UnitEnum? unit) => this.unit = unit;

  NutrientModel.fromJSON(Map<String, dynamic> json)
      : name = NutrientEnum.values.firstWhere((element) => element.apiNutrientName == json['nutrientName']).title,
        value = double.parse(json['nutrientNumber']),
        unit = json['unitName'] != null ? UnitEnum.values.firstWhere((element) => element.notation == json['unitName']) : null;

  NutrientModel copyWith({
    String? name,
    double? value,
    UnitEnum? unit,
  }) =>
      NutrientModel(
        name: name ?? this.name,
        value: value ?? this.value,
        unit: unit ?? this.unit,
      );
}
