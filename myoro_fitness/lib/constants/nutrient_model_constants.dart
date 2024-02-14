import 'dart:math';

import 'package:myoro_fitness/enums/nutrient_enum.dart';
import 'package:myoro_fitness/enums/unit_enum.dart';
import 'package:myoro_fitness/models/nutrient_model.dart';

class NutrientModelConstants {
  static NutrientModel get randomNutrient => NutrientModel(
    name: NutrientEnum.values[Random().nextInt(NutrientEnum.values.length)].name,
    value: Random().nextInt(10000),
    unit: UnitEnum.values[Random().nextInt(UnitEnum.values.length)],
  );

  static NutrientModel specificNutrient(NutrientEnum nutrient) => randomNutrient.copyWith(name: nutrient.name);
}