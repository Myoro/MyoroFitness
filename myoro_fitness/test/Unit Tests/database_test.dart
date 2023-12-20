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

  test('init', () async => await Database().init);
}