import 'dart:io';
import 'package:flutter_app/models/sleepModel.dart';
import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/models/hometimesModel.dart';
import 'package:flutter_app/models/geoModel.dart';
import 'package:flutter_app/models/activityModel.dart';
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
  
 newValue(int id, int steps, int day,int months,int year,int hours,int min ) {
   var map = Map<String, dynamic>();
    map['id'] = id;
    map['numberSteps']=steps;
    map['theTime'] = '12:00:00';
    map['theDay'] = day;
    map['theMonths'] = months;
    map['theYear'] = year;
    map['theHours'] = hours;
    map['theMin'] = min;
    map['thePart'] = 'AM';
    return map;
 } 

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB21.db");
    //await deleteDatabase(path); //supprimer une table apres les tests
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
         await db.execute('''CREATE TABLE Geoloc(id INTEGER PRIMARY KEY AUTOINCREMENT, address TEXT, elapsedTime TEXT, elapsedDuration INTEGER, 
         diffDuration INTEGER, distance INTEGER, coordinates TEXT, vitesse INTEGER, pas INTEGER)''');
         await db.execute('''CREATE TABLE Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         numberSteps INTEGER,
         theTime TEXT,theDay INTEGER,theMonths INTEGER,theYear INTEGER,theHours INTEGER,theMin INTEGER,thePart TEXT)''');
         await db.execute('''CREATE TABLE Sleep (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         duration TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
         await db.execute('''CREATE TABLE HomeTime (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         theTime TEXT,theDay TEXT,theMonths TEXT,theYear TEXT,theHours TEXT,theMin TEXT,thePart TEXT)''');
         await db.execute('''CREATE TABLE Config (id INTEGER PRIMARY KEY AUTOINCREMENT, 
         wifiname TEXT,wifiIP TEXT,hometime INTEGER,sleeptime INTEGER,pedometre INTEGER)''');
         await db.insert('Steps', newValue(1,220, 16,4,2020,8,40),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(2,440, 16,4,2020,8,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(3,330, 15, 4,2020,8,9),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(4,110, 15,4,2020,9,5),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(5,50, 8,4,2020,9,8),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(6,68, 9,4,2020,3,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(7,220, 14,4,2020,8,40),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(8,440, 13,4,2020,8,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(9,330, 12, 4,2020,8,9),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(10,110, 11,4,2020,9,5),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(11,50, 10,4,2020,9,8),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(12,68, 19,4,2020,3,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(13,220, 7,4,2020,8,40),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(14,440, 6,4,2020,8,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(15,330, 5, 4,2020,8,9),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(16,110, 4,4,2020,9,5),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(17,50, 3,4,2020,9,8),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(18,68, 2,4,2020,3,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(19,220, 1,4,2020,8,40),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(20,440, 13,1,2020,8,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(21,330, 12, 2,2020,8,9),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(22,110, 11,3,2020,9,5),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(23,50, 10,4,2020,9,8),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(24,68, 19,5,2020,3,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(25,330, 12, 6,2020,8,9),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(26,110, 11,7,2020,9,5),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(27,50, 10,8,2020,9,8),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(28,68, 19,9,2020,3,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(29,110, 11,10,2020,9,5),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(30,50, 10,11,2020,9,8),  conflictAlgorithm: ConflictAlgorithm.replace);
         await db.insert('Steps', newValue(31,68, 19,12,2020,3,50),  conflictAlgorithm: ConflictAlgorithm.replace);
         
          
          print('database created!');
             /* var yearData = "2020";
    var monthData = "03";
    var dayData = 1;
    var hourData = "00";
    var minData = "00";
    var nbJour = 31;

    for (var i = 1; i <= nbJour; i++) {
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



Future<int> getStepsHour(int yyyy, int mm, int dd,int h,String part) async {
    final db = await database;
    var results = await db.rawQuery('SELECT numberSteps FROM Steps WHERE theYear = $yyyy AND theMonths = $mm AND theDay = $dd AND theHours = $h AND thePart = "$part" ' );
    int res = 0;

    int theTime = 0;
  
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["numberSteps"];
      res=res+theTime;
    }

    return res;
  }
  Future<List<StepsDay>> getStepsDay(int y,int m,int d) async{
    List<StepsDay> res =[];
    


    for (var i = 0; i < 24; i++) {
      StepsDay stepsday=new StepsDay();
    stepsday.theDate=d.toString()+'/'+m.toString()+'/'+y.toString();
      if(i<12){
        stepsday.theHour=i.toString();
        stepsday.numberSteps= await getStepsHour(y, m,d,i,'AM');
      }
      else{
        stepsday.theHour=i.toString();
        stepsday.numberSteps= await getStepsHour(y, m,d,i-12,'PM');
      }
      res.add(stepsday);
    }
    return res;
  }
  Future<int> getStepsMonth(int yyyy, int mm) async {
    final db = await database;
    var results = await db.rawQuery('SELECT numberSteps FROM Steps WHERE theYear = $yyyy AND theMonths = $mm ' );
    int res = 0;

    int theTime = 0;
  
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["numberSteps"];
      res=res+theTime;
    }

    return res;
  }
   Future<int> getStepsDays(int yyyy, int mm,int d) async {
    final db = await database;
    var results = await db.rawQuery('SELECT numberSteps FROM Steps WHERE theYear = $yyyy AND theMonths = $mm AND theDay=$d' );
    int res = 0;

    int theTime = 0;
  
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["numberSteps"];
      res=res+theTime;
    }

    return res;
  }

  Future<List<StepsDays>> getStepsperDay(int y, int m) async {
     List<StepsDays> res =[];
    


    for (var i = 1; i < 32; i++) {
      StepsDays stepsdays=new StepsDays();
      stepsdays.theDate=i.toString()+'/'+m.toString()+'/'+y.toString();
      stepsdays.theDay=i.toString();
      stepsdays.numberSteps= await getStepsDays(y, m,i);
      res.add(stepsdays);
    }
    return res;

  }
 


   Future<List<StepsMonths>> getStepsMonths(int y) async{
    List<StepsMonths> res =[];
    
    for (var i = 1; i < 13; i++) {
      StepsMonths stepsmonths=new StepsMonths();
      stepsmonths.theDate=i.toString()+'/'+y.toString();
      stepsmonths.theMonths=i.toString();
      stepsmonths.numberSteps= await getStepsMonth(y, i);
      res.add(stepsmonths);
      }
    
    return res;
  }
  Future<List<StepsDays>> getStepsWeek(int y, int m,int d) async {
     List<StepsDays> res =[];
    

    if(d>7){
      for (var i = d-7+1; i < d+1; i++) {
        StepsDays stepsdays=new StepsDays();
        stepsdays.theDate=i.toString()+'/'+m.toString()+'/'+y.toString();
        stepsdays.theDay=i.toString();
        stepsdays.numberSteps= await getStepsDays(y, m,i);
        res.add(stepsdays);
      }
      }
    else{
      int a=7-d;
      for (var i = 31-a; i < 31; i++) {
        StepsDays stepsdays=new StepsDays();
        stepsdays.theDate=i.toString()+'/'+m.toString()+'/'+y.toString();
        stepsdays.theDay=i.toString();
        stepsdays.numberSteps= await getStepsDays(y, m,i);
        res.add(stepsdays);
      }
      for (var i = 1; i < d+1; i++) {
        StepsDays stepsdays=new StepsDays();
        stepsdays.theDate=i.toString()+'/'+m.toString()+'/'+y.toString();
        stepsdays.theDay=i.toString();
        stepsdays.numberSteps= await getStepsDays(y, m,i);
        res.add(stepsdays);
        }
      }
          return res;

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
  Future<Geoloc> getLastFetch() async{
    var geoloc = await database;
    var res = await geoloc.rawQuery('SELECT * FROM Geoloc WHERE id =(SELECT MAX(id)  FROM Geoloc)');
     if (res.length > 0) {
      return new Geoloc.fromMap(res.first);
    }
    return null;
  }
  Future<List> getLocalisations() async {
    var geoloc = await database;
    var result = await geoloc.rawQuery('SELECT address FROM Geoloc');
    return result.toList();
}
Future<int> updateGeoloc(Geoloc newGeoloc) async {
    var db = await database;
    return db.update('Geoloc', newGeoloc.toMap(),
        where: 'id = ?', whereArgs: [newGeoloc.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  }
  class StepsDay{
    int numberSteps;
    String theHour;
    String theDate;
  }
    class StepsMonths{
    int numberSteps;
    String theMonths;
    String theDate;
  }
  class StepsDays{
    int numberSteps;
    String theDay;
    String theDate;
  }
 
