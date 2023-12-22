// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/bloc/dark_mode_bloc.dart';
import 'package:myoro_fitness/database.dart';
import 'package:myoro_fitness/widgets/top_bars/main_screen_top_bar.dart';

void main() {
  setUpAll(() async {
    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      if(methodCall.method == 'getApplicationSupportDirectory') return '.';
    });
    await Database().init;
  });

  testWidgets("MainScreenTopBar Widget Test", (tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (context) => BlocProvider(
          create: (context) => DarkModeBloc(),
          child: const MaterialApp(
            title: "MainScreenTopBar Widget Test",
            home: Scaffold(
              appBar: MainScreenTopBar()
            )
          ),
        ),
      )
    );
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsNWidgets(2));
    expect(
      find.byWidgetPredicate((widget) => (
        widget is Text
        &&
        widget.data!.contains("Streak:")
      )),
      findsOneWidget
    );
  });
}