import 'dart:io';
import 'dart:math';
import 'package:flutter_app/models/sleepModel.dart';
import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/models/hometimesModel.dart';
import 'package:flutter_app/models/blueModel.dart';
import 'package:flutter_app/models/geoModel.dart';
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
              print('je ne suis pas null');
    return _database;

    }
    // if _database is null we instantiate it
    _database = await initDB();
    print('initialisation db ');
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
    String path = join(documentsDirectory.path, "TestDB118912123123129998888777123112244.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
          await db.execute('''CREATE TABLE Geoloc(id INTEGER PRIMARY KEY AUTOINCREMENT, address TEXT, elapsedTime TEXT, elapsedDuration INTEGER, 
                          diffDuration INTEGER, distance INTEGER, coordinates TEXT, vitesse INTEGER, pas INTEGER)''');
          await db.execute('''CREATE TABLE Steps (id INTEGER PRIMARY KEY AUTOINCREMENT, 
                          numberSteps INTEGER, theTime INTEGER,theDay INTEGER,theMonths INTEGER,
                          theYear INTEGER,theHours INTEGER,theMin INTEGER,thePart TEXT)''');
          await db.execute('''CREATE TABLE Sleep (id INTEGER PRIMARY KEY AUTOINCREMENT, 
                          duration INTEGER,theDay INTEGER,theMonths INTERGER,theYear INTEGER,
                          theHours TEXT,theMin TEXT,thePart INTEGER)''');
          await db.execute('''CREATE TABLE HomeTime (id INTEGER PRIMARY KEY AUTOINCREMENT, 
                          theTime INTEGER,theDay INTEGER,theMonths INTEGER,theYear INTEGER,
                          theHours TEXT,theMin TEXT,thePart INTEGER)''');
          await db.execute('''CREATE TABLE Config (id INTEGER PRIMARY KEY AUTOINCREMENT, 
                          wifiname TEXT,wifiIP TEXT,hometime INTEGER,sleeptime INTEGER,
                          pedometre INTEGER)''');
          await db.execute('''CREATE TABLE Blue(id INTEGER PRIMARY KEY AUTOINCREMENT, 
                          name TEXT, theTime INTEGER,theDay INTEGER,theMonths INTEGER,theYear INTEGER,theHours INTEGER,theMin INTEGER,thePart TEXT)''');
         
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
/*
    var nbJour = 30;
    for (var i = 1; i <= nbJour; i++) {
      var homeTimes = new HomeTimes(
      id: i,
      theTime: 16 + Random().nextInt(9), //valeur entre 16 et 24 
      theDay: i,
      theMonths: 4,
      theYear: 2020,
      theHours: "20:00",
      theMin: "20:00",
      thePart: 0,
    );
    var sleepTimes = new SleepTime(
      id: i,
      duration: 4 + Random().nextInt(9), //valeur entre 4 et 12
      theDay: i,
      theMonths: 4,
      theYear: 2020,
      theHours: "20:00",
      theMin: "20:00",
      thePart: 0,
    );
    addNewHomeTimes(homeTimes);
    addNewSleepTime(sleepTimes);
    }*/
    /*for (var i = 1; i <= nbJour; i) {
      for (var j = 0; j<= 24; j++){
      var nb = 0;
      if(j<=6){
        nb = 0;
      }
      else if(j==7 || j==10 || j==11 || j==14 || j==15 || j==16){
        nb = 20 + Random().nextInt(21);
      }
      else if (j==8 || j==9 || j==12 || j==13 || j==17 || j==18 || j==19){
        nb = 300 + Random().nextInt(201);
      }
      else if(j==20 || j==21){
        nb = 100 + Random().nextInt(51);
      }
      else {
        nb = 50 + Random().nextInt(21);
      }
      var newSteps = new Steps(
      id: 1+i*j,
      numberSteps: nb,
      theTime: j,
      theDay: i,
      theMonths: json["theMonths"],
      theYear: json["theYear"],
      theHours: json["theHours"],
      theMin: json["theMin"],
      thePart: json["thePart"]
      duration: 16 + Random().nextInt(8), //valeur entre 16 et 24 
      theDay: i,
      theMonths: 4,
      theYear: 2020,
      theHours: "20:00",
      theMin: "20:00",
      thePart: 0,
      );
      addNewSteps(newSteps);
      }
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

   Future<int> getHomeTimesByDay(int yyyy, int mm, int dd) async {
    print('debut getHomeTimesByDay');
    print('$yyyy, $mm, $dd');
    final db = await database;
    print("result");
    var results = await db.rawQuery('SELECT theTime FROM HomeTime WHERE theYear = $yyyy AND theMonth = $mm AND theDay = $dd');
    print("pas de result");
    print(results.length);
    if (results.length > 0) {
      //print(HomeTimes.fromMap(results.first).id);
      var timeHome = 0;
      var theTime = 0;
      for (var i = 0; i < results.length; i++) {
        print("i");
        print(i);
        theTime = results[i]["theTime"];
        timeHome += theTime;
        print("timehome $timeHome");
        i++;
      }
      print("ici 2");
      return timeHome; 
    }
    print("ici");

    return 0;
  }

Future<int> getSleepByDay(int yyyy, int mm, int dd) async {
    final db = await database;
    var results = await db.rawQuery('SELECT duration FROM Sleep WHERE theYear = $yyyy AND theMonths = $mm AND theDay = $dd');
    if (results.length > 0) {
      return new SleepTime.fromMap(results.first).id;
    }
    var sleepTime = 0;
    var theTime = 0;
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["duration"];
      sleepTime += theTime;
    }
    return sleepTime;
  }

  Future<int> getHometimesByDay(int yyyy, int mm, int dd) async {
    final db = await database;
    var results = await db.rawQuery('SELECT theTime FROM Hometime WHERE theYear = $yyyy AND theMonth = $mm AND theDay = $dd');
    if (results.length > 0) {
      return new HomeTimes.fromMap(results.first).id;
    }
    var homeTime = 0;
    var time = 0;
    for (var i = 0; i < results.length; i++) {
      time = results[i]["theTime"];
      homeTime += time;
    }
    return homeTime;
  }

    Future<int> getStepsByDay(int yyyy, int mm, int dd) async {
    final db = await database;
    var results = await db.rawQuery('SELECT theTime FROM Steps WHERE theYear = $yyyy AND theMonth = $mm AND theDay = $dd');

    if (results.length > 0) {
      return new Steps.fromMap(results.first).id;
    }

    var steps = 0;
    var theTime = 0;
  
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["numberSteps"];
      steps += theTime;
    }

    return steps;
  }

Future<int> getSleepbyWeek(int yyyy, int mm, int dd) async {
    int nbDaysByWeek = 7;
    int nbSleep = 0;

    if (dd < nbDaysByWeek) {
      for (var i = 1; i <= dd; i++) {
        nbSleep += await getSleepByDay(yyyy, mm, i);
      }
      if (mm == 1) {
        int nbDaysDecember = 31;
        for (var j = nbDaysDecember; j > nbDaysDecember - nbDaysByWeek + dd; j--) {
          nbSleep += await getSleepByDay(yyyy - 1, mm, j);
        }
      }
      else if (mm == 2 || mm == 4 || mm == 6 || mm == 8 || mm == 9 || mm == 11) {
        int nbDaysBefore = 31;
        for (var j = nbDaysBefore; j > nbDaysBefore - nbDaysByWeek + dd; j--) {
          nbSleep += await getSleepByDay(yyyy, mm, j);
        }
      }
      else if (mm == 3) {
        int nbDaysBefore = 28;
        for (var j = nbDaysBefore; j > nbDaysBefore - nbDaysByWeek + dd; j--) {
          nbSleep += await getSleepByDay(yyyy, mm, j);
        }
      }
      else {
        int nbDaysBefore = 30;
        for (var j = nbDaysBefore; j > nbDaysBefore - nbDaysByWeek + dd; j--) {
          nbSleep += await getSleepByDay(yyyy, mm, j);
        }
      }
    }
    else {
      for (var k = dd; k > dd - 7; k--) {
        nbSleep += await getSleepByDay(yyyy, mm, k);
      }
    }
    return nbSleep;
  }

  Future<int> getHomeTimesbyWeek(int yyyy, int mm, int dd) async {
    int nbDaysByWeek = 7;
    int hometime = 0;

    if (dd < nbDaysByWeek) {
      for (var i = 1; i <= dd; i++) {
        hometime += await getHomeTimesByDay(yyyy, mm, i);
      }
      if (mm == 1) {
        int nbDaysDecember = 31;
        for (var j = nbDaysDecember; j > nbDaysDecember - nbDaysByWeek + dd; j--) {
          hometime += await getHometimesByDay(yyyy - 1, mm, j);
        }
      }
      else if (mm == 2 || mm == 4 || mm == 6 || mm == 8 || mm == 9 || mm == 11) {
        int nbDaysBefore = 31;
        for (var j = nbDaysBefore; j > nbDaysBefore - nbDaysByWeek + dd; j--) {
          hometime += await getHometimesByDay(yyyy, mm, j);
        }
      }
      else if (mm == 3) {
        int nbDaysBefore = 28;
        for (var j = nbDaysBefore; j > nbDaysBefore - nbDaysByWeek + dd; j--) {
          hometime += await getHometimesByDay(yyyy, mm, j);
        }
      }
      else {
        int nbDaysBefore = 30;
        for (var j = nbDaysBefore; j > nbDaysBefore - nbDaysByWeek + dd; j--) {
          hometime += await getHometimesByDay(yyyy, mm, j);
        }
      }
    }
    else {
      for (var k = dd; k > dd - 7; k--) {
        hometime += await getHometimesByDay(yyyy, mm, k);
      }
    }
    return hometime;
  }

  List<int> getDateLastDay(int yyyy, int mm, int dd) {
    var res = [0, 0, 0];
    if (dd == 1) {
      if (mm == 1) {
        int nbDaysDecember = 31;
        res = [yyyy - 1, 12, nbDaysDecember];
      }
      else if (mm == 2 || mm == 4 || mm == 6 || mm == 8 || mm == 9 || mm == 11) {
        int nbDaysBefore = 31;
        res = [yyyy, mm - 1, nbDaysBefore - 1];
      }
      else if (mm == 3) {
        int nbDaysBefore = 28;
        res = [yyyy, mm - 1, nbDaysBefore - 1];
      }
      else {
        int nbDaysBefore = 30;
        res = [yyyy, mm - 1, nbDaysBefore - 1];
      }
    }
    else {
      res = [yyyy, mm, dd - 1];
    }
    return res;
  }

  Future<int> getSleepTimesMean(int yyyy, int mm, int dd, int sampleSize) async {
    int sleepTime = 0;
    var tmp;

    for (var i = 0; i < sampleSize; i++) {
      sleepTime += await getSleepByDay(yyyy, mm, dd);
      tmp = getDateLastDay(yyyy, mm, dd);
      yyyy = tmp[0];
      mm = tmp[1];
      dd = tmp[2];
    }
    return (sleepTime ~/ sampleSize);
  }

  Future<int> getHomeTimesMean(int yyyy, int mm, int dd, int sampleSize) async {
    int homeTime = 0;
    var tmp;

    for (var i = 0; i < sampleSize; i++) {
      homeTime += await getHometimesByDay(yyyy, mm, dd);
      tmp = getDateLastDay(yyyy, mm, dd);
      yyyy = tmp[0];
      mm = tmp[1];
      dd = tmp[2];
    }
    return (homeTime ~/ sampleSize);
  }

  List<int> getDateLastWeek(int yyyy, int mm, int dd) {
    int nbDaysByWeek = 7;
    var res = [0,0,0];

    if (dd < nbDaysByWeek) {
      if (mm == 1) {
        int nbDaysDecember = 31;
        res = [yyyy - 1, 12, nbDaysDecember - nbDaysByWeek + dd];
      }
      else if (mm == 2 || mm == 4 || mm == 6 || mm == 8 || mm == 9 || mm == 11) {
        int nbDaysBefore = 31;
        res = [yyyy, mm - 1, nbDaysBefore - nbDaysByWeek + dd];
      }
      else if (mm == 3) {
        int nbDaysBefore = 28;
        res = [yyyy, mm - 1, nbDaysBefore - nbDaysByWeek + dd];
      }
      else {
        int nbDaysBefore = 30;
        res = [yyyy, mm - 1, nbDaysBefore - nbDaysByWeek + dd];
      }
    }
    else {
      res = [yyyy, mm, dd - 7];
    }
    return res;
  }

  Future<int> getStepsByMonth(int yyyy, int mm, int dd) async {
    int nbSteps = 0;
    List<int> d2, d3, d4;

    nbSteps += await getSleepbyWeek(yyyy, mm, dd);
    
    d2 = getDateLastWeek(yyyy, mm, dd);
    nbSteps += await getSleepbyWeek(d2[0], d2[1], d2[2]);

    d3 = getDateLastWeek(d2[0], d2[1], d2[2]);
    nbSteps += await getSleepbyWeek(d3[0], d3[1], d3[2]);

    d4 = getDateLastWeek(d3[0], d3[1], d3[2]);
    nbSteps += await getSleepbyWeek(d4[0], d4[1], d4[2]);

    return nbSteps;
  }

Future<List<int>> getStepsInDay(int yyyy, int mm, int dd) async {
    final db = await database;
    var results = await db.rawQuery('SELECT numberSteps FROM Steps WHERE theYear = $yyyy AND theMonth = $mm AND theDay = $dd');
    List<int> res = [];

    // if (results.length > 0) {
    //   return new Steps.fromMap(results.first).id;
    // }

    int theTime = 0;
  
    for (var i = 0; i < results.length; i++) {
      theTime = results[i]["numberSteps"];
      res.add(theTime);
    }

    return res;
  }

 /*Future<int> getHomeTimesByWeek(int yyyy, int mm, int dd) async {
    print('debut getHomeTimesByWeek');
    print('$yyyy, $mm, $dd');
    final db = await database;
    int timeHome =0;
    var m = mm%2;
    int jour = 0;
    if (mm==1 || mm==2){
      if (m==2) jour = 28;
      else jour = 30;
    }else jour = 31;
    int count=0;
    if (dd < 8){
      if (mm>1){
        for (var day = 0; day < dd ; day++){
          timeHome += await getHomeTimesByDay(yyyy, mm, day);
        }
        for (var day = 0;day<1 ;day++)
      if(mm==1){

      }
    }else{
      for (var day = dd; day < dd-7 ; day++){
        var results += await db.rawQuery('SELECT id FROM HomeTime WHERE theYear = $yyyy AND theMonths = $mm AND theDay = $day');

      }
    }
    
    var results = await db.rawQuery('SELECT id FROM HomeTime WHERE theYear = $yyyy AND theMonths = $mm AND theDay = $dd');
        if (results.length > 0) {
      print(HomeTimes.fromMap(results.first).id);
          }
      for (var i = 0; i < results.length; i++) {
      }
      return timeHome; 
    }
    return 0;
 }*/

 /*Future<int> getHomeTimesByMonth(String yyyy, String mm) async {
    print('debut getHomeTimesByMonth');
    print('$yyyy, $mm');
    final db = await database;
    var results = await db.rawQuery('SELECT id FROM HomeTime WHERE theYear = $yyyy AND theMonths = $mm');
    if (results.length > 0) {
      var timeHome = 0;
      var theTime = 0;
      for (var i = 0; i < results.length; i++) {
        theTime = results[i]["theTime"];
        timeHome += theTime;
      }
      return timeHome; 
    }
    return 0;
 }*/
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
   Future<int> addNewBlue(Blue newblue) async {
    print('adding new data blue...');

    final db = await database;
    var raw = db.insert( 'Blue', newblue.toMap(),  conflictAlgorithm: ConflictAlgorithm.replace);

    print('data added blue !');
    return raw;
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
 