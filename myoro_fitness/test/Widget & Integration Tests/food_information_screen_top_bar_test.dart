import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/top_bars/food_information_screen_top_bar.dart';

import '../constants/food_constants.dart';

void main() {
  testWidgets("FoodInformationScreenTopBar Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "FoodInformationScreenTopBar Widget Test",
        home: Scaffold(
          appBar: FoodInformationScreenTopBar(
            food: FoodConstants.food,
            addFoodToPendingMeal: () {},
          )
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => (widget is Icon && widget.icon == Icons.check)), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => (widget is Icon && widget.icon == Icons.close)), findsOneWidget);
  });
}