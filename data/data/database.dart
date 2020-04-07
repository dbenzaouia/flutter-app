import 'dart:io';
import '../Config.dart';

import '../models/sleepModel.dart';
import '../models/stepsModel.dart';
import '../models/hometimesModel.dart';
import '../data/database.dart';
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
    String path = join(documentsDirectory.path, "TestDB442321.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
          await db.execute('''CREATE TABLE Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         numberSteps INTEGER,
         theTime TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
          await db.execute('''CREATE TABLE Sleep (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         duration TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
         await db.execute('''CREATE TABLE HomeTime (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         theTime TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
         await db.execute('''CREATE TABLE Config (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         wifiname TEXT,wifiIP TEXT,hometime INTEGER,sleeptime INTEGER,pedometre INTEGER)''');
          
          print('database created!');
    });
    
  }

  Future<int> addNewSteps(Steps newSteps) async {
    print('adding new data...');

    final db = await database;
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

  Future<int> addNewSleepTime(SleepTime newSleepTime) async {
    print('adding new sleep data...');

    final db = await database;
    var raw = db.insert( 'Sleep', newSleepTime.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data sleep added !');
    return raw;
  }
    Future<List<SleepTime>> fetchSleepAll() async {
    var sleep = await database;
    var res = await sleep.query('sleep');

    if (res.isNotEmpty) {
      var thesleep = res.map((stepMap) => SleepTime.fromMap(stepMap)).toList();
      return thesleep;
    }
    return [];
  }
   Future<int> addNewHomeTimes(HomeTimes newHomeTimes) async {
    print('adding new data hometimes...');

    final db = await database;
    var raw = db.insert( 'HomeTime', newHomeTimes.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data Hometime added !');
    return raw;
  }
   Future<List<HomeTimes>> fetchAlltimes() async {
    var hometimes = await database;
    var res = await hometimes.query('HomeTime');

    if (res.isNotEmpty) {
      var thehometime = res.map((hometimeMap) => HomeTimes.fromMap(hometimeMap)).toList();
      return thehometime;
    }
    return [];
  }

  Future<int> addNewConfig(Config newConfig) async {
    print('adding new config...');

    final db = await database;
    var raw = db.insert( 'Config', newConfig.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('config added !');
    return raw;
  }

   Future<int> updateConfig(Config config) async {
    print('updating config...');

    final db = await database;
    var raw = db.update("Config", config.toMap(), where: "id = 1");
    print('config updated !');
    return raw;
  }

   getConfig(int id) async {
    final db = await database;
    var res = await db.query("Config", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Config.fromMap(res.first) : null;
  }

  Future<int> getConfigsid(int id) async {
    final db = await database;
    var results = await db.rawQuery('SELECT id FROM Config WHERE id = $id');

    if (results.length > 0) {
      return new Config.fromMap(results.first).id;
    }

    return null;
  }

  Future<List<Config>> fetchAllConfig() async {
    var config = await database;
    var res = await config.query('Config');

    if (res.isNotEmpty) {
      var theconfigs = res.map((stepMap) => Config.fromMap(stepMap)).toList();
      return theconfigs;
    }
    return [];
  }

     Future<int> getHomeTimesByDay(String yyyy, String mm, String dd) async {
    final db = await database;
    var results = await db.rawQuery('SELECT id FROM HomeTime WHERE theYear = $yyyy AND theMonth = $mm AND theDay = $dd');

    if (results.length > 0) {
      return new HomeTimes.fromMap(results.first).id;
    }

    var timeHome = 0;
    var theTime = 0;
  
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["theTime"];
      timeHome += theTime;
    }

    return timeHome;
  }

  }