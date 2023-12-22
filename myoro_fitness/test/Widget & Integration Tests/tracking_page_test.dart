// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:myoro_fitness/database.dart';
import 'package:myoro_fitness/pages/tracking_page.dart';
import 'package:myoro_fitness/widgets/basic_dropdown.dart';
import 'package:myoro_fitness/widgets/basic_input.dart';
import 'package:myoro_fitness/widgets/buttons/text_hover_button.dart';

void main() {
  setUpAll(() async {
    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      if(methodCall.method == 'getApplicationSupportDirectory') return '.';
    });
    await Database().init;
  });

  testWidgets("TrackingPage Widget Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        title: "TrackingPage Widget Test",
        home: Scaffold(
          body: Column(
            children: [
              TrackingPage()
            ]
          )
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.byType(Wrap), findsWidgets);
    expect(find.text("Log your streak"), findsOneWidget);
    expect(find.text("Calories:"), findsOneWidget);
    expect(find.text("Weight:"), findsOneWidget);
    expect(find.text("Exercised?:"), findsOneWidget);
    expect(find.byType(BasicInput), findsWidgets);
    expect(find.byType(BasicDropdown), findsOneWidget);
    expect(find.byType(TextHoverButton), findsOneWidget);
    expect(find.text("Log  ${DateFormat('dd-MM-yyyy').format(DateTime.now())}"), findsOneWidget);
  });
}