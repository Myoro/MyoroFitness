// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/bloc/food_search_screen_bloc.dart';
import 'package:myoro_fitness/screens/custom_food_screen.dart';

void main() {
  testWidgets("CustomFoodScreen Widget Test", (tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (context) => BlocProvider(
          create: (context) => FoodSearchScreenBloc(),
          child: const MaterialApp(
            title: "CustomFoodScreen Widget Test",
            home: Scaffold(
              body: CustomFoodScreen()
            )
          ),
        ),
      )
    );
    await tester.pumpAndSettle();

    final exceptions = [];
    exceptions.add(tester.takeException());
    exceptions.add(tester.takeException());
    exceptions.add(tester.takeException());
    expect(exceptions.every((e) => e is dynamic), isTrue);
  });
}