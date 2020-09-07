import 'package:NotePad/database/models/Notepad.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotepadHelper {
  static final NotepadHelper _notepadHelper = NotepadHelper._internal();

  static final tableName = "notepad";
  static final columnID = "id";
  static final title = "title";
  static final data = "data";
  static final description = "description";

  Database _database;

  factory NotepadHelper() {
    return _notepadHelper;
  }

  NotepadHelper._internal();

  get database async {
    if (_database != null) {
      return _database;
    }

    _database = await startDataBase();

    return _database;
  }

  _onCreateDB(Database database, int version) async {
    String sql =
        "CREATE TABLE $tableName ($columnID INTEGER PRIMARY KEY AUTOINCREMENT, $title VARCHAR, $description TEXT, $data DATETIME)";
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

  Future<int> saveNotepadHelper(Notepad notepad) async {
    var dataBase = await database;

    int resultID = await dataBase.insert(
      tableName,
      notepad.toMap(),
    );
    return resultID;
  }

  Future<int> updateNotepad(Notepad notepad) async {
    var dataBase = await database;
    return await dataBase.update(
      tableName,
      notepad.toMap(),
      where: "id = ?",
      whereArgs: [notepad.id],
    );
  }

  Future<int> deleteNotepad(int id) async {
    var dataBase = await database;
    return await dataBase.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  getNotePadListHelper() async {
    var dataBase = await database;

    String sql = "SELECT * FROM $tableName ORDER BY $data DESC";
    List notepads = await dataBase.rawQuery(sql);
    return notepads;
  }
}
