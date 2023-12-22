import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/pages/settings_page.dart';
import 'package:myoro_fitness/widgets/buttons/text_hover_button.dart';

void main() {
  testWidgets("SettingsPage Widget Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        title: "SettingsPage Widget Test",
        home: Scaffold(
          body: Column(
            children: [
              SettingsPage()
            ]
          )
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.byType(TextHoverButton), findsWidgets);
    expect(find.text("Modify TDEE/Deficit"), findsOneWidget);
    expect(find.text("Export your data to JSON"), findsOneWidget);
    expect(find.text("Import your JSON data"), findsOneWidget);
  });
}