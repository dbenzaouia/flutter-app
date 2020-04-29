import 'package:flutter/material.dart';
import './../models/stepsModel.dart';
import './../data/database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import '../service/hometime.dart';
import './../widget/pedometer_widget.dart';
import './../models/ObjectDisplay.dart';

import './../widget/hometime_widget.dart';




class HomeGraph extends StatefulWidget {
    HomeGraphState createState() => new HomeGraphState();
}
enum Types { rien,journalier, hebdomadaire, mensuel }

class HomeGraphState extends State<HomeGraph> {

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  int day=0;
  int months=0;
  int year=0;
  int hours=0;
  int min=0;
  String part="";
  int _changed=0;
  HometimeWidget homeDay = new HometimeWidget();
  HometimeWidgetMonths homeMonth = new HometimeWidgetMonths();
  HometimeWidgetWeek homeWeek = new HometimeWidgetWeek();


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
          title: Text("HomeTime"),
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
            homeDay.hometimeWidgetday(),
            homeMonth.hometimeWidgetMonth(),
            homeWeek.hometimeWidgetweek(),
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
static Future<List<charts.Series<DataList, DateTime>>> withDataWeek() async {
      return (
      await  _createDataWeek()
    );
  }
static Future<List<charts.Series<DataList, DateTime>>> withDataMonth() async {
    return (
    await  _createDataMonth()
  );
}

  static Future <List<charts.Series<DataDay, String>>> _createDataDay() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    DBProvider().initDB();
    var time = await DBProvider().getHomeTimesByDay(y,m,d);
    var hour = 24*3600-time;
    hour = hour ~/3600;
    time = time ~/3600;
    final data = [
      new DataDay('home', time),
      new DataDay('outside', hour),
    ];
    return [
      new charts.Series<DataDay, String>(
          id: 'home',
          data: data,
          colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
          domainFn: (DataDay hometimes, _) => hometimes.location,
          measureFn: (DataDay hometimes, _) => hometimes.time,
          labelAccessorFn: (DataDay row, _) => '${row.location}: ${row.time}',
      )
    ];
  }

  static Future <List<charts.Series<DataList, DateTime>>> _createDataWeek() async {
   int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    List listday = [];
    DBProvider().initDB();
    var time = await DBProvider().getHomeTimesList(y,m,d,7);
    List<DataList> data = [];
    for(int i=0; i<time.length; i++ ){
      data.add(new DataList(new DateTime(y,m,d), time[i]~/3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataList, DateTime>(
          id: 'wifi',
          data: data,
          colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
          domainFn: (DataList hometimes, _) => hometimes.day,
          measureFn: (DataList hometimes, _) => hometimes.time,
      )
    ];
  }

  static Future <List<charts.Series<DataList, DateTime>>> _createDataMonth() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    List listday = [];
    DBProvider().initDB();
    var time = await DBProvider().getHomeTimesList(y,m,d,30);
    List<DataList> data = [];
    for(int i=0; i<time.length; i++ ){
      data.add(new DataList(new DateTime(y,m,d), time[i]~/3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataList, DateTime>(
          id: 'wifi',
          data: data,
          colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
          domainFn: (DataList hometimes, _) => hometimes.day,
          measureFn: (DataList hometimes, _) => hometimes.time,
      )
    ];
  }
}