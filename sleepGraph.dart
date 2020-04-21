import 'package:flutter/material.dart';
import 'package:flutter_app/data/database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:flutter_app/sleepTime.dart';
import 'models/ObjectDisplay.dart';

import 'package:flutter_app/widget/sleeptime_widget.dart';




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
    Types _chang = Types.rien;
    if(_changed==0)
       return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Quel type de graphe?',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), 
               Column(
                children: <Widget>[
                  ListTile(
                  title: const Text('journalier'),
                  leading: Radio(
                  value: Types.journalier,
                  groupValue: _chang,

                  onChanged: (Types value) {
                    setState(() { 
                      _chang = value;
                      _changed=1;
                    });
                  },
                ),
               ),
       
              ListTile(
                title: const Text('hebdomadaire'),
                leading: Radio(
                value: Types.hebdomadaire,
                groupValue: _chang,

                onChanged: (Types value) {
                setState(() { 
                  _chang = value;
                  _changed=2;
                 });
                },
              ),
            ),
            ListTile(
              title: const Text('mensuel'),
              leading: Radio(
              value: Types.mensuel,
              groupValue: _chang,

              onChanged: (Types value) {
              setState(() { 
                _chang = value; 
                _changed=3;
                  });
                },
              ),
            ),
          ],
        ),
      ]
    )
  );  
            
  else if (_changed==1){
        return sleepDay.sleeptimeWidgetday();
      }
  else if(_changed==3){
        return sleepMonth.sleeptimeWidgetMonth();

      }
  else if(_changed==2){
        return sleepWeek.sleeptimeWidgetweek();
      }
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
          labelAccessorFn: (DataDay sleeptime, _) => sleeptime.hour + ' : ${sleeptime.time}'
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
      data.add(new DataListS(new DateTime(y,m,d), time[i]%3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataListS, DateTime>(
          id: 'sleepW',
          data: data,
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
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
      data.add(new DataListS(new DateTime(y,m,d), time[i]%3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataListS, DateTime>(
          id: 'sleepM',
          data: data,
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (DataListS sleeptimes, _) => sleeptimes.day,
          measureFn: (DataListS sleeptimes, _) => sleeptimes.time,
      )
    ];
  }
}
