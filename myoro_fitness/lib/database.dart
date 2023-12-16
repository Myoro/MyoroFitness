import "dart:io";
import "package:sqflite/sqflite.dart" as sqflite;
import "package:sqflite_common_ffi/sqflite_ffi.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart";

class Database {
  static final Database _singletonInstance = Database._internal();
  late sqflite.Database _db;

  factory Database() => _singletonInstance;

  Database._internal();

  Future<String> getDatabasePath() async {
    Directory applicationRootDirectory;

    if(Platform.isAndroid || Platform.isIOS) {
      applicationRootDirectory = await getApplicationDocumentsDirectory();
    } else {
      applicationRootDirectory = await getApplicationSupportDirectory();
    }

    return join(applicationRootDirectory.path, "myorofitness.db");
  }

  Future<void> _init() async {
    if(!Platform.isAndroid && !Platform.isIOS) sqflite.databaseFactory = databaseFactoryFfi;

    _db = await sqflite.openDatabase(await getDatabasePath());

    // calorie_plan table
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS calorie_plan(
        id              INTEGER PRIMARY KEY,
        tdee            INTEGER,
        calorie_deficit INTEGER,
        remind_user     INTEGER
      );
    ''');
    List<Map<String, Object?>> row = await _db.query("calorie_plan");
    if(row.isEmpty) await _db.insert("calorie_plan", { "tdee": 0, "calorie_deficit": 0, "remind_user": 1 });

    // added_foods table (history of what the user has added)
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS added_foods(
        id   INTEGER PRIMARY KEY AUTOINCREMENT,
        food TEXT
      );
    ''');

    // Foods
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS meals(
        id        INTEGER PRIMARY KEY AUTOINCREMENT,
        meal_name TEXT,
        foods     TEXT
      );
    ''');
    row = await _db.query("meals");
    if(row.isEmpty) {
      await _db.insert("meals", { "meal_name": "Breakfast", "foods": "[]" });
      await _db.insert("meals", { "meal_name": "Lunch", "foods": "[]" });
      await _db.insert("meals", { "meal_name": "Dinner", "foods": "[]" });
      await _db.insert("meals", { "meal_name": "Snacks", "foods": "[]" });
    }

    // Streaks
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS streak_entries(
        id        INTEGER PRIMARY KEY AUTOINCREMENT,
        calories  INTEGER,
        weight    INTEGER,
        exercised INTEGER,
        date      TEXT
      );
    ''');
  }

  Future<void> get init async { await _init(); }

  Future<List<Map<String, Object?>>> select(String table, [ Map<String, dynamic>? conditions ]) async {
    final List<Map<String, Object?>> rows = await _db.query(
      table,
      where: (conditions != null) ? conditions.keys.first : null,
      whereArgs: (conditions != null) ? conditions.values.first : null
    );
    return rows;
  }

  Future<Map<String, Object?>> get(String table, [ Map<String, dynamic>? conditions ]) async {
    final List<Map<String, Object?>> row = await select(table, conditions);
    if(row.isEmpty) { return {}; }
    else            { return row[0]; }
  }

  Future<void> insert(String table, Map<String, dynamic> data) async => await _db.insert(table, data);

  Future<void> update(String table, String attribute, dynamic value, [ Map<String, String>? conditions ]) async {
    await _db.update(
      table,
      { attribute: value },
      where: (conditions != null) ? conditions.keys.first : null,
      whereArgs: [ (conditions != null) ? conditions.values.first : null ]
    );
  }

  Future<void> resetDatabase() async {
    if(!Platform.isAndroid && !Platform.isIOS) sqflite.databaseFactory = databaseFactoryFfi;
    await sqflite.deleteDatabase(await getDatabasePath());
  }
}