// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/bloc/meal_bloc.dart';
import 'package:myoro_fitness/bloc/tdee_bloc.dart';
import 'package:myoro_fitness/database.dart';
import 'package:myoro_fitness/pages/calories_page.dart';
import 'package:myoro_fitness/widgets/cards/meal_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      if(methodCall.method == 'getApplicationSupportDirectory') return '.';
    });
    await Database().init;
  });

  testWidgets("CaloriesPage Widget Test", (tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TDEEBloc()),
            BlocProvider(create: (context) => MealBloc())
          ],
          child: const MaterialApp(
            title: "CaloriesPage Widget Test",
            home: Scaffold(
              body: Column(
                children: [
                  CaloriesPage()
                ]
              )
            )
          ),
        ),
      )
    );
    await tester.pumpAndSettle();

    expect(find.text("Calorie Max:"), findsNothing);
    expect(find.text("Calories consumed:"), findsNothing);
    expect(find.byType(MealCard), findsWidgets);
  });
}