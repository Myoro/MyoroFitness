import "dart:io";
import "package:sqflite/sqflite.dart" as sqflite;
import "package:sqflite_common_ffi/sqflite_ffi.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart";

class Database {
  static final Database _singletonInstance = Database._internal();
  late sqflite.Database _db;

  factory Database() => _singletonInstance;

  Database._internal() { init(); }

  void init() async {
    Directory applicationRootDirectory;

    if(Platform.isAndroid || Platform.isIOS) {
      applicationRootDirectory = await getApplicationDocumentsDirectory();
    } else {
      applicationRootDirectory = await getApplicationSupportDirectory();
      sqflite.databaseFactory = databaseFactoryFfi;
    }


    _db = await sqflite.openDatabase(
      join(applicationRootDirectory.path, "myorofitness.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS calorie_plan(
            id              INTEGER PRIMARY KEY,
            tdee            INTEGER,
            calorie_deficit INTEGER
          );
        ''');
      }
    );
  }

  void close() async { await _db.close(); }
}