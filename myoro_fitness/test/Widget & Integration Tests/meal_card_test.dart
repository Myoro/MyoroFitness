// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/models/food.dart';
import 'package:myoro_fitness/widgets/cards/meal_card.dart';

import '../constants/food_constants.dart';
import '../constants/meal_constants.dart';

void main() {
  int mealTotalCalories = 0;

  setUp(() { for(final Food food in MealConstants.meal.foods) mealTotalCalories += food.calories!.value; });

  testWidgets("MealCard Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "MealCard Widget TEst",
        home: Scaffold(
          body: MealCard(
            mealName: MealConstants.meal.name,
            meal: MealConstants.meal
          )
        )
      )
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate((widget) => (
        widget is Row
        &&
        widget.children[0] is Text
        &&
        (widget.children[0] as Text).data == MealConstants.meal.name
      )),
      findsOneWidget
    );
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Divider), findsNWidgets(2));
    expect(
      find.byWidgetPredicate((widget) => (
        widget is Row
        &&
        widget.children[0] is Expanded
        &&
        (widget.children[0] as Expanded).child is Column
        &&
        (((widget.children[0] as Expanded).child as Column).children[0] as Text).data == "Foo"
        &&
        (((widget.children[0] as Expanded).child as Column).children[1] as Text).data == "Foo Company"
        &&
        widget.children[2] is Text
        &&
        (widget.children[2] as Text).data == "${(FoodConstants.food.calories!.value * FoodConstants.food.serving).toStringAsFixed(0)}cals"
      )),
      findsNWidgets(5)
    );
    expect(find.text("${MealConstants.meal.name} Total: $mealTotalCalories"), findsOneWidget);
  });
}