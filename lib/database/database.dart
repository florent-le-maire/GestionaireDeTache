import 'dart:io';

import 'package:gestionnaire_de_tache/model/model_liste.dart';
import 'package:gestionnaire_de_tache/model/model_tache.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  static Database _database;

  DBProvider();

  DBProvider._();

  static final DBProvider db = DBProvider._();

  Future<Database> get database async {
    // if db exist => return db
    if (_database != null) {
      return _database;
    }
    //if db don't exist => create db
    _database = await initDB();
    return _database;
  }

  // Initialise the data base
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'gestionTache.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
      await db.execute(tableTache);
      await db.execute(tableListe);
    });
  }


  // table tache containing tache information
  final String tableTache= "CREATE TABLE tache ("
      "id_tache INTEGER PRIMARY KEY,"
      "title TEXT NOT NULL,"
      "date TEXT,"
      "id_liste INTEGER,"
      "status INTEGER DEFAULT 1"
      ")";

  //table liste containing liste informatio,
  final String tableListe = "CREATE TABLE liste ("
      "id_liste integer,"
      "title TEXT NOT NULL"
      ")";

  /////////////////////Table tache\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  addTacheToDatabase(Tache tache) async {
    final db = await database;
    var raw = await db.insert(
      "tache",
      tache.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }
  Future<int> updateTache(Tache tache) async {
    var db = await this.database;
    var result = await db.update('tache', tache.toJson(),
        where: 'id_tache = ?', whereArgs: [tache.id_tache]);
    return result;
  }

  // get tache by id tache
  Future<Tache> getTacheByIdTache(int id_tache) async {
    final db = await database;
    var response = await db.query("tache", where: "id_tache = ?", whereArgs: [id_tache]);
    return response.isNotEmpty ? Tache.fromJson(response.first) : null;
  }

  // get tache by id liste
  Future<List<Tache>> getTacheByIdListe(int id_liste) async {
    final db = await database;
    var response = await db.query("tache", where: "id_liste = ?", whereArgs: [id_liste]);
    List<Tache> list = response.map((e) => Tache.fromJson(e)).toList();
    return list;
  }
    // get tache all tache pas terminé
  Future<List<Tache>> getAllTacheEnCours() async {
    final db = await database;
    var response = await db.query("tache", where: "status = 1");
    List<Tache> list = response.map((e) => Tache.fromJson(e)).toList();
    return list;
  }
  // get tache all tache terminé
  Future<List<Tache>> getAllTacheTermine() async {
    final db = await database;
    var response = await db.query("tache", where: "status = 0");
    List<Tache> list = response.map((e) => Tache.fromJson(e)).toList();
    return list;
  }
  deleteTacheWithId(int id_tache) async {
    final db = await database;
    return db.delete("tache", where: "id_tache = ?", whereArgs: [id_tache]);
  }


  /////////////////////Table liste\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  addListeToDatabase(Liste liste) async {
    final db = await database;
    var raw = await db.insert(
      "liste",
      liste.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }
  Future<int> updateListe(Liste liste) async {
    var db = await this.database;
    var result = await db.update('liste', liste.toJson(),
        where: 'id_liste = ?', whereArgs: [liste.id_liste]);
    return result;
  }

  Future<List<Liste>> getAllListe() async {
    final db = await database;
    var response = await db.query("liste");
    List<Liste> list = response.map((e) => Liste.fromJson(e)).toList();
    return list;
  }
  deleteListeWithId(int id_liste) async {
    final db = await database;
    return db.delete("liste", where: "id_liste = ?", whereArgs: [id_liste]);
  }


}