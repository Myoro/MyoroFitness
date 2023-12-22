// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/widgets/basic_dropdown.dart';

void main() {
  final List<String> items = [ "Dropdown", "Items" ];

  testWidgets("BasicDropdown Widget Test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "BasicDropdown Widget Test",
        home: Scaffold(
          body: BasicDropdown(items: items)
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.text(items[0]), findsOneWidget);
    await tester.tap(find.byType(BasicDropdown));
    await tester.pumpAndSettle();
    for(final String item in items) expect(find.text(item), item != items[0] ? findsOneWidget : findsWidgets);
  });
}