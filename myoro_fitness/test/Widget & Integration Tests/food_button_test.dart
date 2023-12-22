import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/buttons/food_button.dart';

import '../constants/food_constants.dart';

void main() {
  testWidgets("FoodButton Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "FoodButton Widget Test",
        home: Scaffold(
          body: FoodButton(food: FoodConstants.food)
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.text(FoodConstants.food.name), findsOneWidget);
    expect(find.text(FoodConstants.food.company!), findsOneWidget);
    expect(find.text("${FoodConstants.food.calories!.value}kcals"), findsOneWidget);
  });
}