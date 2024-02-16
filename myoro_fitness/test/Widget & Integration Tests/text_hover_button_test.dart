import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/buttons/text_hover_button.dart';

void main() {
  testWidgets("TextHoverButton Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "TextHoverButton Widget Test",
        home: Scaffold(
          body: TextHoverButton(
            title: "Foo",
            onTap: () {}
          )
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.text("Foo"), findsOneWidget);
  });
}