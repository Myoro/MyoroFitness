import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';

void main() {
  testWidgets("ButtonWithoutFeedback Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "ButtonWithoutFeedback Widget Test",
        home: Scaffold(
          body: ButtonWithoutFeedback(
            child: const Text("Foo"),
            onTap: () {}
          )
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.text("Foo"), findsOneWidget);
  });
}