import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/top_bars/custom_food_screen_top_bar.dart';

void main() {
  testWidgets("CustomFoodScreen Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "CustomFoodScreen Widget Test",
        home: Scaffold(
          appBar: CustomFoodScreenTopBar(addFoodToPendingMeal: () {})
        )
      )
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate((widget) => (widget is Icon && widget.icon == Icons.check)),
      findsOneWidget
    );
    expect(
      find.byWidgetPredicate((widget) => (widget is Icon && widget.icon == Icons.close)),
      findsOneWidget
    );
  });
}