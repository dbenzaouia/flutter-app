import 'package:flutter/material.dart';
import 'package:flutter_app/data/database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:flutter_app/homeSleep.dart';
import 'hometime.dart';
import 'sleepTime.dart';
import 'models/ObjectDisplay.dart';

import 'package:flutter_app/widget/homeSleep_widget.dart';
import 'widget/sleeptime_widget.dart';




class HSGraph extends StatefulWidget {
    HSGraphState createState() => new HSGraphState();
}
enum Types { rien,journalier, hebdomadaire, mensuel }

class HSGraphState extends State<HSGraph> {

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  int day=0;
  int months=0;
  int year=0;
  int hours=0;
  int min=0;
  String part="";
  int _changed=0;
  HSWidgetMonths hsMonth = new HSWidgetMonths();
  HSWidgetWeek hsWeek = new HSWidgetWeek();


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
            
  else if(_changed==3){
        return hsMonth.hsWidgetMonth();

      }
  else if(_changed==2){
        return hsWeek.hsWidgetWeek();
      }
  }
 

static Future<List<charts.Series<DataListHS, DateTime>>> hsDataWeek() async {
      return (
      await  _createDataWeek()
    );
  }
static Future<List<charts.Series<DataListHS, DateTime>>> hsDataMonth() async {
    return (
    await  _createDataMonth()
  );
}

  
  static Future <List<charts.Series<DataListHS, DateTime>>> _createDataWeek() async {
   int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    List listday = [];
    DBProvider().initDB();
    var home = await DBProvider().getHomeTimesList(y,m,d,7);
    var sleep = await DBProvider().getSleepTimesList(y,m,d,7);
    List<DataListHS> datas = [];
    List<DataListHS> datah = [];
    for(int i=0; i<7; i++ ){
      datas.add(new DataListHS(new DateTime(y,m,d), sleep[i]%3600));
      datah.add(new DataListHS(new DateTime(y,m,d), home[i]%3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataListHS, DateTime>(
          id: 'homeW',
          data: datah,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          areaColorFn: (_, __) =>
            charts.MaterialPalette.red.shadeDefault.lighter,
          domainFn: (DataListHS hometimes, _) => hometimes.day,
          measureFn: (DataListHS hometimes, _) => hometimes.time,
      ),
      new charts.Series<DataListHS, DateTime>(
          id: 'sleepW',
          data: datas,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
          domainFn: (DataListHS sleeptimes, _) => sleeptimes.day,
          measureFn: (DataListHS sleeptimes, _) => sleeptimes.time,
      )
    ];
  }

  static Future <List<charts.Series<DataListHS, DateTime>>> _createDataMonth() async {
   int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    List listday = [];
    DBProvider().initDB();
    var home = await DBProvider().getHomeTimesList(y,m,d,30);
    var sleep = await DBProvider().getSleepTimesList(y,m,d,30);
    List<DataListHS> datas = [];
    List<DataListHS> datah = [];
    for(int i=0; i<30; i++ ){
      datas.add(new DataListHS(new DateTime(y,m,d), sleep[i]%3600));
      datah.add(new DataListHS(new DateTime(y,m,d), home[i]%3600));
      listday = DBProvider.getDateLastDay(y, m, d);
      d = listday[2];
      y = listday[0];
      m = listday[1];
    };
    return [
      new charts.Series<DataListHS, DateTime>(
          id: 'homeM',
          data: datah,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          areaColorFn: (_, __) =>
            charts.MaterialPalette.red.shadeDefault.lighter,
          domainFn: (DataListHS hometimes, _) => hometimes.day,
          measureFn: (DataListHS hometimes, _) => hometimes.time,
      ),
      new charts.Series<DataListHS, DateTime>(
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