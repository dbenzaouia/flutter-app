import 'dart:io';
import 'package:app/models/sleepModel.dart';
import 'package:app/models/stepsModel.dart';
import 'package:app/models/blueModel.dart';

import 'package:app/models/hometimesModel.dart';
import 'package:app/models/geoModel.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../configModel.dart';


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
  
 newValue(int id, int steps, String day) {
   var map = Map<String, dynamic>();
    map['id'] = id;
    map['theTime'] = '12:00:00';
    map['theDay'] = day;
    map['theMonths'] = '04';
    map['theYear'] = '2020';
    map['theHours'] = '12';
    map['theMin'] = '00';
    map['thePart'] = '0';
    return map;
 } 

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB91231234.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
         await db.execute('''CREATE TABLE Geoloc(id INTEGER PRIMARY KEY AUTOINCREMENT, address TEXT, elapsedTime TEXT)''');
        await db.execute('''CREATE TABLE Blue(id INTEGER PRIMARY KEY AUTOINCREMENT, 
         name TEXT,
         theTime INTEGER,theDay INTEGER,theMonths INTEGER,theYear INTEGER,theHours INTEGER,theMin INTEGER,thePart TEXT)''');

         await db.execute('''CREATE TABLE Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         numberSteps INTEGER,
         theTime TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
         await db.execute('''CREATE TABLE Sleep (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         duration TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
         await db.execute('''CREATE TABLE HomeTime (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         theTime TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
         await db.execute('''CREATE TABLE Config (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         wifiname TEXT,wifiIP TEXT,hometime INTEGER,sleeptime INTEGER,pedometre INTEGER)''');
         /*await db.insert('HomeTime', newValue(1, 3, '06'),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('HomeTime', newValue(2, 60, '06'),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('HomeTime', newValue(3, 151, '06'),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('HomeTime', newValue(4, 34, '06'),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('HomeTime', newValue(5, 25, '06'),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('HomeTime', newValue(6, 13, '06'),  conflictAlgorithm: ConflictAlgorithm.replace);
         */
          
          print('database created!');
              var yearData = "2020";
    var monthData = "03";
    var dayData = 1;
    var hourData = "00";
    var minData = "00";
    var nbJour = 31;

    /*for (var i = 1; i <= nbJour; i++) {
      var homeTimes = new HomeTimes(
      id: i,
      theTime: "02:50:00",
      theDay: dayData.toString(),
      theMonths: monthData,
      theYear: yearData,
      theHours: hourData,
      theMin: minData,
      thePart: "6",
    );
    addNewHomeTimes(homeTimes);
    }*/

  });

}

  Future<int> addNewSteps(Steps newSteps) async {
    print('adding new data...');

    final db = await database;
    var raw = db.insert( 'Steps', newSteps.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data added !');
    return raw;
  }
  Future<int> addNewBlue(Blue newblue) async {
    print('adding new data blue...');

    final db = await database;
    var raw = db.insert( 'Blue', newblue.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data added blue !');
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
  Future<List<Blue>> fetchAllBlues() async {
    var blue = await database;
    var res = await blue.query('blue');

    if (res.isNotEmpty) {
      var theblue = res.map((stepMap) => Blue.fromMap(stepMap)).toList();
      return theblue;
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
    print('debut getHomeTimesByDay');
    print(yyyy+','+ mm+',' +dd);
    final db = await database;
    print('apres db');
    var t = await db.rawQuery('SELECT SUM(theTime) FROM HomeTime WHERE theYear = $yyyy AND theMonths = $mm AND theDay = $dd');
    var results = await db.rawQuery('SELECT id FROM HomeTime WHERE theYear = $yyyy AND theMonths = $mm AND theDay = $dd');
    print(results);
    if (results.length > 0) {
      print(HomeTimes.fromMap(results.first).id);
    }
    var timeHome = 0;
    var theTime = 0;
    print('apres la requette');
  
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["theTime"];
      timeHome += theTime;
    }
    print('timehome : ');
    print(timeHome);
    print('sum');
    print(t);

    return timeHome;
  }

  Future<int> addNewGeoloc(Geoloc geoloc) async {
    print('adding new Geoloc data...');

    final db = await database;
    var raw = db.insert( 'Geoloc', geoloc.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data Geoloc added !');
    return raw;
  }
  Future<List<Geoloc>> fetchLocationsAll() async {
    var geoloc = await database;
    var res = await geoloc.query('geoloc');

    if (res.isNotEmpty) {
      var thelocation = res.map((locationMap) => Geoloc.fromMap(locationMap)).toList();
      return thelocation;
    }
    return [];
  }

  }