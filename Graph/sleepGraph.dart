import 'package:flutter/material.dart';
import './../data/database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import './../service/sleepTime.dart';
import '../models/ObjectDisplay.dart';

import './../widget/sleeptime_widget.dart';




class SleepGraph extends StatefulWidget {
    SleepGraphState createState() => new SleepGraphState();
}
enum Types { rien,journalier, hebdomadaire, mensuel,annuel }

class SleepGraphState extends State<SleepGraph> {

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  int day=0;
  int months=0;
  int year=0;
  int hours=0;
  int min=0;
  String part="";
  int _changed=0;
  SleeptimeWidget sleepDay = new SleeptimeWidget();
  SleeptimeWidgetMonths sleepMonth = new SleeptimeWidgetMonths();
  SleeptimeWidgetWeek sleepWeek = new SleeptimeWidgetWeek();


  static int todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    String formattedDate = formatter.format(now);
    int day = int.parse(formattedDate);
    print('day : ' +formattedDate);
    return day;
  }

  static int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String formattedDate = formatter.format(now);
    int month = int.parse(formattedDate);
    print('month : ' + formattedDate);
    return month;

  }
  static int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    int year = int.parse(formattedDate);
    print('Year : ' + formattedDate);
    return year;
  }

  String todayHours() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('kk').format(now);
    print('Hours : ' + formattedTime);
    return formattedTime;
  }

  int todayMin() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('mm').format(now));
    return formattedTime;

  }
  String today() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('a').format(now);
    return formattedTime;
  }

  void initState() {
    super.initState();   
  }


 Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("SleepTime"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'journalier',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              Tab(
                  child: Text(
                'hebdomadaire',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )),
              Tab(
                  child: Text(
                'mensuel',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            sleepDay.sleeptimeWidgetday(),
            sleepMonth.sleeptimeWidgetMonth(),
            sleepWeek.sleeptimeWidgetweek(),
          ],
        ),
      ),
    );
  }
 

 static Future<List<charts.Series<DataDay, String>>> withDataDay() async {
    return (
    await  _createDataDay()
    );
  }
  static Future<List<charts.Series<DataListS, DateTime>>> withDataWeek() async {
    return (
    await  _createDataWeek()
    );
  }
  static Future<List<charts.Series<DataListS, DateTime>>> withDataMonth() async {
    return (
    await  _createDataMonth()
    );
  }

  static Future <List<charts.Series<DataDay, String>>>_createDataDay() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    DBProvider().initDB();
    var time = await DBProvider().getSleepByDay(y,m,d);
    var hour = 24*3600-time;
    time = time ~/3600;
    hour = hour ~/3600;
    final data = [
      new DataDay('sleep', time),
      new DataDay('awake', hour),
    ];
    return [
      new charts.Series<DataDay, String>(
          id: 'sleep',
          data: data,
          domainFn: (DataDay sleeptime, _) => sleeptime.hour,
          measureFn: (DataDay sleeptime, _) => sleeptime.time,
      )
    ];
  }

  static Future <List<charts.Series<DataListS, DateTime>>> _createDataWeek() async {
   int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    List listday = [];
    DBProvider().initDB();
    var time = await DBProvider().getSleepTimesList(y,m,d,7);
    List<DataListS> data = [];
    for(int i=0; i<time.length; i++ ){
      data.add(new DataListS(new DateTime(y,m,d), time[i]~/3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataListS, DateTime>(
          id: 'sleepW',
          data: data,
          domainFn: (DataListS sleeptimes, _) => sleeptimes.day,
          measureFn: (DataListS sleeptimes, _) => sleeptimes.time,
      )
    ];
  }

  static Future <List<charts.Series<DataListS, DateTime>>> _createDataMonth() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    List listday = [];
    DBProvider().initDB();
    var time = await DBProvider().getSleepTimesList(y,m,d,30);
    List<DataListS> data = [];
    for(int i=0; i<time.length; i++ ){
      data.add(new DataListS(new DateTime(y,m,d), time[i]~/3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataListS, DateTime>(
          id: 'sleepM',
          data: data,
          domainFn: (DataListS sleeptimes, _) => sleeptimes.day,
          measureFn: (DataListS sleeptimes, _) => sleeptimes.time,
      )
    ];
  }
}
