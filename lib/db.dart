import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:tarea8_flutter/models/log.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  final String DB_NAME = "Database.db";
  final String tableName = "entradas_diario";
  final String columnID = "ID";
  final String columnTitulo = "titulo";
  final String columnFecha = "fecha";
  final String columnDescripcion = "descripcion";
  final String columnFotoPath = "fotoPath";
  final String columnAudioPath = "audioPath";



  static Database? _db;

  AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  } 

  Future<Database?> get db async {
    if (_db != null) return _db!;

    _db = await getDb(DB_NAME);
    return _db;
  }

  Future<Database> getDb(String fileName) async {
    String dbPath = await getDatabasesPath();
    String finalPath = p.join(dbPath, fileName);

    return await openDatabase(finalPath, version: 1, onCreate: initDb);
  }

  Future<void> initDb(Database db, int? version) async {
    db.execute(
    '''
      CREATE TABLE $tableName (
        $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitulo TEXT not null, 
        $columnDescripcion TEXT not null,
        $columnFecha  INTEGER not null,
        $columnFotoPath TEXT,
        $columnAudioPath TEXT  
      )
    '''
    );
  }

  Future<void> insertLog(Log entrada) async {
    final db = await _instance.db;

    db!.insert(tableName, entrada.toMap());
  }

  Future<List<Log>> getAllEntries() async {
    List<Log> datos = [];
    final db = await _instance.db;

    List<Map> entradas = await db!.query(tableName);

    for (Map entrada in entradas) {
      datos.add(Log.fromMap(entrada));
    }

    return datos;
  }

  Future<void> deleteLog(int? ID) async {
    if (ID != null) {
      final db = await _instance.db;
      db!.delete(tableName, where: 'ID = ?', whereArgs: [ID]);
    }else {
      throw Exception("Error inesperado: (ID = NULL)");
    }
    

  }

  Future<void> deleteAll() async {
    final db = await _instance.db;
    db!.delete(tableName);

  }


}