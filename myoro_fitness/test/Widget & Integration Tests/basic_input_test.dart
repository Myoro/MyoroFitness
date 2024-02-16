import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/basic_input.dart';

void main() {
  testWidgets("BasicInput Widget Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        title: "BasicInput Widget Test",
        home: Scaffold(
          body: BasicInput(placeholder: "Foo")
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.text("Foo"), findsOneWidget);
  });
}