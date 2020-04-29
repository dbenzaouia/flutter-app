import 'package:flutter/material.dart';
import './../data/database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import './../service/homeSleep.dart';
import '../service/hometime.dart';
import '../service/sleepTime.dart';
import '../models/ObjectDisplay.dart';

import './../widget/homeSleep_widget.dart';
import '../widget/sleeptime_widget.dart';

class HSGraph extends StatefulWidget {
  HSGraphState createState() => new HSGraphState();
}

enum Types { rien, journalier, hebdomadaire, mensuel }

class HSGraphState extends State<HSGraph> {
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  int day = 0;
  int months = 0;
  int year = 0;
  int hours = 0;
  int min = 0;
  String part = "";
  int _changed = 0;
  HSWidgetMonths hsMonth = new HSWidgetMonths();
  HSWidgetWeek hsWeek = new HSWidgetWeek();
  HSWidgetDay hsDay = new HSWidgetDay();

  static int todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    String formattedDate = formatter.format(now);
    int day = int.parse(formattedDate);
    return day;
  }

  static int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String formattedDate = formatter.format(now);
    int month = int.parse(formattedDate);
    return month;
  }

  static int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    int year = int.parse(formattedDate);
    return year;
  }

  String todayHours() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('kk').format(now);
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
            hsDay.hsWidgetDay(),
            hsMonth.hsWidgetMonth(),
            hsWeek.hsWidgetWeek(),
          ],
        ),
      ),
    );
  }

  static Future<List<charts.Series<DataDayHS, String>>> hsDataDay() async {
    return (await _createDataDay());
  }

  static Future<List<charts.Series<DataListHS, String>>> hsDataWeek() async {
    return (await _createDataWeek());
  }

  static Future<List<charts.Series<DataListHS, String>>> hsDataMonth() async {
    return (await _createDataMonth());
  }

  static Future<List<charts.Series<DataDayHS, String>>> _createDataDay() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    DBProvider().initDB();
    var home = await DBProvider().getHomeTimesByDay(y, m, d);
    var sleep = await DBProvider().getSleepByDay(y, m, d);
    var outside = 24 * 3600 - home;
    home = home - sleep;
    final data = [
      new DataDayHS('Sleep', sleep),
      new DataDayHS('Home', home),
      new DataDayHS('Outside', outside)
    ];
    return [
      new charts.Series<DataDayHS, String>(
        id: 'hsDay',
        data: data,
        domainFn: (DataDayHS data, _) => data.location,
        measureFn: (DataDayHS data, _) => data.time,
      )
    ];
  }

  static Future<List<charts.Series<DataListHS, String>>>
      _createDataWeek() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    String day = d.toString();
    List listday = [];
    DBProvider().initDB();
    var home = await DBProvider().getHomeTimesList(y, m, d, 7);
    var sleep = await DBProvider().getSleepTimesList(y, m, d, 7);
    List<DataListHS> datas = [];
    List<DataListHS> datah = [];
    for (int i = 0; i < 7; i++) {
      datas.add(new DataListHS(day, sleep[i] ~/ 3600));
      datah.add(new DataListHS(day, home[i] ~/ 3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      day = d.toString();
      y = listday[0];
      m = listday[1];
    }
    ;
    return [
      new charts.Series<DataListHS, String>(
        id: 'hometime',
        data: datah,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (DataListHS hometimes, _) => hometimes.day,
        measureFn: (DataListHS hometimes, _) => hometimes.time,
      ),
      new charts.Series<DataListHS, String>(
        id: 'sleeptime',
        data: datas,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (DataListHS sleeptimes, _) => sleeptimes.day,
        measureFn: (DataListHS sleeptimes, _) => sleeptimes.time,
      )
    ];
  }

  static Future<List<charts.Series<DataListHS, String>>>
      _createDataMonth() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    String day = d.toString();
    List listday = [];
    DBProvider().initDB();
    var home = await DBProvider().getHomeTimesList(y, m, d, 30);
    var sleep = await DBProvider().getSleepTimesList(y, m, d, 30);
    List<DataListHS> datas = [];
    List<DataListHS> datah = [];
    for (int i = 0; i < 30; i++) {
      datas.add(new DataListHS(day, sleep[i] ~/ 3600));
      datah.add(new DataListHS(day, home[i] ~/ 3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
      day = d.toString();
    }
    ;
    return [
      new charts.Series<DataListHS, String>(
        id: 'homeM',
        data: datah,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (DataListHS hometimes, _) => hometimes.day,
        measureFn: (DataListHS hometimes, _) => hometimes.time,
      ),
      new charts.Series<DataListHS, String>(
        id: 'sleepM',
        data: datas,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (DataListHS sleeptimes, _) => sleeptimes.day,
        measureFn: (DataListHS sleeptimes, _) => sleeptimes.time,
      )
    ];
  }
}
