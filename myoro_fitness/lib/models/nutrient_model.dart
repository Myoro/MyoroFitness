import 'package:myoro_fitness/enums/unit_enum.dart';

class NutrientModel {
  final String name;
  final int value;
  final UnitEnum? unit;

  NutrientModel.fromJSON(Map<String, dynamic> json)
      : name = json['nutrientName'],
        value = int.parse(json['nutrientNumber']),
        unit = json['unitName'] != null ? UnitEnum.values.firstWhere((element) => element.notation == json['unitName']) : null;
}
