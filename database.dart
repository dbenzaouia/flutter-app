<<<<<<< HEAD
import 'dart:io';
import 'package:flutter_app/models/stepsModel.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;
  
  factory DBProvider() {
    return db;
  }

  Future<Database> get database async {
    if (_database != null){
    return _database;
    }
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB9111222.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      /*await db.execute("CREATE TABLE Steps ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "numberSteps INTEGER,"
          "theTime TEXT,"
          ")"); */
          await db.execute('''CREATE TABLE Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         numberSteps INTEGER,
         theTime TEXT)''');
          
          print('database created!');
    });
    
  }

  Future<int> addNewSteps(Steps newSteps) async {
    print('adding new data...');

    final db = await database;
    //get the biggest id in the table
    //var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Steps");
    //int id = table.first["id"];
    //insert to the table using the new id
   /* var raw = await db.rawInsert(
        "INSERT Into Steps (numberSteps,theTime)"
        " VALUES (?,?)",
        [ newSteps.numberSteps , newSteps.theTime]);*/
        var raw = db.insert( 'Steps', newSteps.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data added !');
    return raw;
  }

   getSteps(int id) async {
    final db = await database;
    var res = await db.query("Steps", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Steps.fromMap(res.first) : null;
  }

  Future<int> getStepsid(int id) async {
    final db = await database;
    var results = await db.rawQuery('SELECT id FROM Steps WHERE id = $id');

    if (results.length > 0) {
      return new Steps.fromMap(results.first).id;
    }

    return null;
  }

  Future<List<Steps>> fetchAll() async {
    var steps = await database;
    var res = await steps.query('steps');

    if (res.isNotEmpty) {
      var thesteps = res.map((stepMap) => Steps.fromMap(stepMap)).toList();
      return thesteps;
    }
    return [];
  }
=======
import 'dart:io';
import 'models/stepsModel.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;
  
  factory DBProvider() {
    return db;
  }

  Future<Database> get database async {
    if (_database != null){
    return _database;
    }
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB9111222.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      /*await db.execute("CREATE TABLE Steps ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "numberSteps INTEGER,"
          "theTime TEXT,"
          ")"); */
          await db.execute('''CREATE TABLE Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         numberSteps INTEGER,
         theTime TEXT)''');
          
          print('database created!');
    });
    
  }

  Future<int> addNewSteps(Steps newSteps) async {
    print('adding new data...');

    final db = await database;
    //get the biggest id in the table
    //var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Steps");
    //int id = table.first["id"];
    //insert to the table using the new id
   /* var raw = await db.rawInsert(
        "INSERT Into Steps (numberSteps,theTime)"
        " VALUES (?,?)",
        [ newSteps.numberSteps , newSteps.theTime]);*/
        var raw = db.insert( 'Steps', newSteps.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data added !');
    return raw;
  }

   getSteps(int id) async {
    final db = await database;
    var res = await db.query("Steps", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Steps.fromMap(res.first) : null;
  }

  Future<int> getStepsid(int id) async {
    final db = await database;
    var results = await db.rawQuery('SELECT id FROM Steps WHERE id = $id');

    if (results.length > 0) {
      return new Steps.fromMap(results.first).id;
    }

    return null;
  }

  Future<List<Steps>> fetchAll() async {
    var steps = await database;
    var res = await steps.query('steps');

    if (res.isNotEmpty) {
      var thesteps = res.map((stepMap) => Steps.fromMap(stepMap)).toList();
      return thesteps;
    }
    return [];
  }
>>>>>>> 95be933528873a3afbcc51773040e71fbf49b352
  }