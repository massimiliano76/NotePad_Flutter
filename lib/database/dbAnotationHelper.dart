import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotationHelperDB {
  static final AnotationHelperDB _anotationHelperDB =
      AnotationHelperDB._internal();

  Database _database;

  factory AnotationHelperDB() {
    return _anotationHelperDB;
  }

  AnotationHelperDB._internal() {}

  getDataBase() async {
    if (_database != null) {
      return _database;
    }

    startDataBase();
  }

  _onCreateDB(Database database, int version) async {
    String sql =
        "CREATE TABLE notepad (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR, description TEXT, data DATETIME)";
    await database.execute(sql);
  }

  startDataBase() async {
    final pathDataBase = await getDatabasesPath();
    final localDataBase = join(pathDataBase, "notepad.db");

    var response = await openDatabase(
      localDataBase,
      version: 1,
      onCreate: _onCreateDB,
    );

    return response;
  }
}
