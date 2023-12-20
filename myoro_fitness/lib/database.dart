import "dart:io";
import "package:intl/intl.dart";
import "package:sqflite/sqflite.dart" as sqflite;
import "package:sqflite_common_ffi/sqflite_ffi.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart";

class Database {
  static final Database _singletonInstance = Database._internal();
  late sqflite.Database _db;

  factory Database() => _singletonInstance;

  Database._internal();

  Future<String> _getDatabasePath() async {
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

    _db = await sqflite.openDatabase(await _getDatabasePath());

    // dark_mode table
    await _db.execute("CREATE TABLE IF NOT EXISTS dark_mode(id INTEGER PRIMARY KEY, enabled INTEGER);");
    List<Map<String, Object?>> row = await _db.query("dark_mode");
    if(row.isEmpty) await _db.insert("dark_mode", { "enabled": 1 });

    // calorie_plan table
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS calorie_plan(
        id              INTEGER PRIMARY KEY,
        tdee            INTEGER,
        calorie_deficit INTEGER,
        remind_user     INTEGER
      );
    ''');
    row = await _db.query("calorie_plan");
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

    // Saves current date to reset meal / streak
    await _db.execute('CREATE TABLE IF NOT EXISTS meal_date(id INTEGER PRIMARY KEY, date TEXT);');
    row = await _db.query("meal_date");
    if(row.isEmpty) _db.insert("meal_date", { "date": DateFormat("dd-MM-yyyy").format(DateTime.now()) });
  }

  Map<String, dynamic> _formatConditions(Map<String, dynamic>? conditions) {
    if(conditions == null) return { "where": null, "whereArgs": null };

    String where = "";
    final List<dynamic> whereArgs = [];

    for(int i = 0; i < conditions.length; i++) {
      where += "${conditions.keys.elementAt(i)} = ?${i != conditions.length - 1 ? ' AND' : ''}";
      whereArgs.add(conditions.values.elementAt(i));
    }

    return { "where": where, "whereArgs": whereArgs };
  }

  Future<void> get init async => await _init();

  Future<List<Map<String, Object?>>> select(String table, [ Map<String, dynamic>? conditions ]) async {
    conditions = _formatConditions(conditions);

    final List<Map<String, Object?>> rows = await _db.query(
      table,
      where: conditions["where"],
      whereArgs: conditions["whereArgs"]
    );
    return rows;
  }

  Future<Map<String, Object?>> get(String table, [ Map<String, dynamic>? conditions ]) async {
    final List<Map<String, Object?>> row = await select(table, conditions);
    if(row.isEmpty) { return {}; }
    else            { return row[0]; }
  }

  Future<void> insert(String table, Map<String, dynamic> data) async => await _db.insert(table, data);

  Future<void> update(String table, String attribute, dynamic value, [ Map<String, dynamic>? conditions ]) async {
    conditions = _formatConditions(conditions);

    await _db.update(
      table,
      { attribute: value },
      where: conditions["where"],
      whereArgs: conditions["whereArgs"]
    );
  }

  Future<void> resetDatabase() async {
    if(!Platform.isAndroid && !Platform.isIOS) sqflite.databaseFactory = databaseFactoryFfi;
    await sqflite.deleteDatabase(await _getDatabasePath());
  }
}