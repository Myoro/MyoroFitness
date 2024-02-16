// ignore_for_file: curly_braces_in_flow_control_structures

import "package:flutter_test/flutter_test.dart";
import "package:myoro_fitness/api.dart";
import "package:myoro_fitness/models/food.dart";
import "package:myoro_fitness/models/nutrient.dart";

void main() {
  test('getFoods', () async {
    final List<Food> foods = await API.getFoods('Coke');
    for(final Food food in foods) {
      expect(food.name, isNotNull);
      if(food.company != null) expect(food.company, isNotEmpty);
      if(food.calories != null)
        if(food.calories!.unit != null)
          expect(food.calories!.unit == Unit.kcal, true);
      expect(food.serving, 1);
    }
  });
}