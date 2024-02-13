import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Database {
  static late sqflite.Database _database;

  static Future<String> getDatabasePath() async => join(
        (await getApplicationSupportDirectory()).path,
        'myoro_fitness',
      );

  static Future<void> init() async {
    if (!Platform.isIOS && !Platform.isAndroid) sqflite.databaseFactory = databaseFactoryFfi;

    _database = await sqflite.openDatabase(await getDatabasePath());

    // Dark mode table
    await _database.execute('CREATE TABLE IF NOT EXISTS dark_mode(id INTEGER PRIMARY KEY, enabled INTEGER);');
    if ((await get('dark_mode')).isEmpty) insert('dark_mode', {'enabled': 0});

    // Calorie plan table
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS calorie_plan(
        id               INTEGER PRIMARY KEY AUTOINCREMENT,
        tdee             INTEGER,
        calories_per_day INTEGER
      );
    ''');
    if ((await get('calorie_plan')).isEmpty) insert('calorie_plan', {'tdee': 0, 'calories_per_day': 0});
  }

  static Future<void> close() async {
    await sqflite.deleteDatabase(await getDatabasePath());
    await _database.close();
  }

  static Future<List<Map<String, Object?>>> select(String table, [Map<String, Object?>? conditions]) async {
    return await _database.query(table);
  }

  static Future<Map<String, Object?>> get(String table, [Map<String, Object?>? conditions]) async {
    final List<Map<String, Object?>> rows = await select(table, conditions);
    return rows.isEmpty ? {} : rows[0];
  }

  static Future<void> insert(String table, Map<String, Object?> data) async => _database.insert(table, data);

  static Future<void> update(String table, Map<String, Object?> data, [Map<String, Object?>? conditions]) async {
    await _database.update(table, data);
  }
}
