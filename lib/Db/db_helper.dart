import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // create database
  static Future<Database> openDb() async {
    final path = join(await getDatabasesPath(), 'app_note.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, position TEXT, skill TEXT, category TEXT, date TEXT)",
        );
      },
    );
  }

  // insert data
  static Future<int> intsetNote(
    String Position,
    String Skill,
    String Category,
    String Date,
  ) async {
    final db = await DbHelper.openDb();
    return db.insert('note', {
      'position': Position,
      'skill': Skill,
      'category': Category,
      'date': Date,
    });
  }

  // getdata
  static Future<List<Map<String, dynamic>>> getNote() async {
    final db = await openDb();
    return db.query('note');
  }

  //delete
  static Future<int> deleteNote(int id) async {
    final db = await openDb();
    return db.delete('note', where: "id = ?", whereArgs: [id]);
  }

  // update
  static Future<int> update(
    int id,
    String newPosition,
    String newSkill,
    String newCategory,
    String newDate,
  ) async {
    final db = await openDb();
    return db.update(
      "note",
      {
        "position": newPosition,
        "skill": newSkill,
        "category": newCategory,
        "date": newDate,
      },
      where: "id=?",
      whereArgs: [id],
    );
  }
}
