// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      if(methodCall.method == 'getApplicationSupportDirectory') return '.';
    });
  });

  test('init & resetDatabase', () async {
    await Database().init;
    expect(await Database().get("dark_mode"), isNotEmpty);
    expect(await Database().get("calorie_plan"), isNotEmpty);
    expect(await Database().get("added_foods"), isEmpty);
    expect(await Database().get("meals"), isNotEmpty);
    expect(await Database().get("streak_entries"), isEmpty);
    expect(await Database().get("meal_date"), isNotEmpty);
    await Database().resetDatabase();
  });

  test('insert & update', () async {
    await Database().init;
    await Database().insert("added_foods", { "food": "foo" });
    Map<String, Object?> row = await Database().get("added_foods");
    expect(row["food"] == "foo", true);
    await Database().update("added_foods", "food", "foo foo", { "food": "foo" });
    row = await Database().get("added_foods");
    expect(row["food"] == "foo foo", true);
    await Database().resetDatabase();
  });
}