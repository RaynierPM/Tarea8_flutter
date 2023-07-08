import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class AppDatabase {
  static final AppDatabase _instance = AppDatabase.init();

  final String DB_NAME = "Database.db";

  static Database? _db;

  AppDatabase.init();

  factory AppDatabase() {
    return _instance;
  } 

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await getDb(DB_NAME);
    return _db!;
  }

  Future<Database> getDb(String fileName) async {
    String dbPath = await getDatabasesPath();
    String finalPath = p.join(dbPath, fileName);

    return await openDatabase(finalPath, version: 1, onCreate: initDb);
  }

  Future<void> initDb(Database db, int? version) async {
    db.execute(
    '''
      CREATE TABLE entradas_diario (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
         
      )
    '''
    );
  }




}