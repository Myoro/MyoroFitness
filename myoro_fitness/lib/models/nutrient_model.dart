import 'package:myoro_fitness/enums/unit_enum.dart';

class NutrientModel {
  final String name;
  final int value;
  final UnitEnum? unit;

  NutrientModel({
    required this.name,
    required this.value,
    this.unit,
  });

  set value(int value) => this.value = value;
  set unit(UnitEnum? unit) => this.unit = unit;

  NutrientModel.fromJSON(Map<String, dynamic> json)
      : name = json['nutrientName'],
        value = int.parse(json['nutrientNumber']),
        unit = json['unitName'] != null ? UnitEnum.values.firstWhere((element) => element.notation == json['unitName']) : null;

  NutrientModel copyWith({
    String? name,
    int? value,
    UnitEnum? unit,
  }) =>
      NutrientModel(
        name: name ?? this.name,
        value: value ?? this.value,
        unit: unit ?? this.unit,
      );
}
