import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';

class NoteDatabase {
  NoteDatabase();

  static final NoteDatabase db = NoteDatabase();
  static Database? _database;
  String table = 'Notes';
  String recordId = 'recordId';
  String title = 'title';
  String id = 'id';
  String description = 'description';
  String location = 'location';
  String time = 'time';
  String priority = 'priority';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join('${dir.path}Note3DB.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE $table('
        '$recordId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$id TEXT,'
        '$title TEXT,'
        '$description TEXT,'
        '$location TEXT,'
        '$time TEXT,'
        '$priority TEXT)');
  }

  Future<List<NoteModel>> getNote(String id) async {
    Database? db = await database;
    final List<Map<String, dynamic>> noteMapList = await db!.query('$table WHERE $id = $id');
    final List<NoteModel> noteList = [];
    for (var noteMap in noteMapList) {
      noteList.add(NoteModel.fromJson(noteMap));
    }
    return noteList;
  }

  /// INSERT
  Future<NoteModel> insertNote(NoteModel note) async {
    Database? db = await database;
    await db!.insert(table, note.toMap());
    return note;
  }

  /// UPDATE
  Future<int> updateNote(NoteModel note) async {
    Database? db = await database;
    return await db!.update(table, note.toMap(),
        where: '$recordId = ?', whereArgs: [note.id]);
  }

  /// DELETE
  Future<int> deleteNotes(NoteModel note) async {
    Database? db = await database;
    return await db!.delete(table,
        where: '$recordId = ?', whereArgs: [note.id]);
  }

}
