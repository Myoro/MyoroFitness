// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/screens/food_information_screen.dart';
import 'package:myoro_fitness/widgets/basic_input.dart';

import '../constants/food_constants.dart';

void main() {
  testWidgets("FoodInformationScreen Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "FoodInformationScreen Widget Test",
        home: FoodInformationScreen(
          food: FoodConstants.food,
          index: 0
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.byType(BasicInput), findsOneWidget);
    expect(find.text("Protein:"), findsOneWidget);
    expect(find.text("Fat:"), findsOneWidget);
    expect(find.text("Carbs:"), findsOneWidget);
    expect(find.text("${(FoodConstants.food.calories!.value * FoodConstants.food.serving).toStringAsFixed(0)} Calories"), findsOneWidget);
    expect(find.text("${FoodConstants.food.protein!.value}${FoodConstants.food.protein!.unit!.unit}"), findsOneWidget);
    expect(find.text("${FoodConstants.food.fat!.value}${FoodConstants.food.fat!.unit!.unit}"), findsOneWidget);
    expect(find.text("${FoodConstants.food.carbohydrates!.value}${FoodConstants.food.carbohydrates!.unit!.unit}"), findsOneWidget);
    expect(find.text("Ingredients"), findsOneWidget);
    for(final String ingredient in FoodConstants.food.ingredients!.ingredients) expect(find.text("- $ingredient"), findsOneWidget);
    expect(find.text("Delete Food"), findsOneWidget);
  });
}
