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
    final List<Map<String, Object?>> row = await _db.query("calorie_plan");
    if(row.isEmpty) await _db.insert("calorie_plan", { "tdee": 0, "calorie_deficit": 0, "remind_user": 1 });
  }

  Future<void> get init async { await _init(); }

  Future<List<Map<String, Object?>>> select(String table, [ Map<String, String>? conditions ]) async {
    final List<Map<String, Object?>> rows = await _db.query(table);
    return rows;
  }

  // SELECT query returning only 1 row
  Future<Map<String, Object?>> get(String table, [ Map<String, String>? conditions ]) async {
    final List<Map<String, Object?>> row = await select(table);
    if(row.isEmpty) { return {}; }
    else            { return row[0]; }
  }

  void update(String table, String attribute, dynamic value, [ Map<String, String>? conditions ]) async {
    await _db.update(table, { attribute: value });
  }

  Future<void> resetDatabase() async {
    if(!Platform.isAndroid && !Platform.isIOS) sqflite.databaseFactory = databaseFactoryFfi;
    await sqflite.deleteDatabase(await getDatabasePath());
  }
}