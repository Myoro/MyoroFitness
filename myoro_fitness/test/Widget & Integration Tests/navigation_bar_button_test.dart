import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/buttons/navigation_bar_button.dart';

void main() {
  testWidgets("BasicInput Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "BasicInput Widget Test",
        home: Scaffold(
          body: Column(
            children: [
              NavigationBarButton(
                onTap: () {},
                selected: false,
                child: const Text("Foo1")
              ),
              NavigationBarButton(
                onTap: () {},
                selected: true,
                child: const Text("Foo2")
              )
            ]
          )
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.text("Foo1"), findsOneWidget);
    expect(find.text("Foo2"), findsOneWidget);
    expect(
      find.byWidgetPredicate((widget) => (
        widget is Container
        &&
        (widget.decoration as BoxDecoration).color == null
      )),
      findsOneWidget
    );
    expect(
      find.byWidgetPredicate((widget) => (
        widget is Container
        &&
        (widget.decoration as BoxDecoration).color != null
      )),
      findsOneWidget
    );
  });
}