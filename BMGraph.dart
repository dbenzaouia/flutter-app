
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_app/data/database.dart';
import 'package:flutter_app/data/BlueManager.dart';
import 'package:flutter_app/models/blueModel.dart';
import 'package:flutter_app/widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';



class BMG extends StatefulWidget {


  BMGState createState() => new BMGState();
  
 
}


class BlueObjet{
  String name;
  String fonction;

 
}

class BMGState extends State<BMG> {
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<Blue> blues = [];

  List<BlueDay> bluedayfirst = [];

  List<BlueDay> bluedaysecond = [];
  List<BlueDay> bluedaythird = [];



  static BlueObjet bal=make("X8","media");
  static BlueObjet ball=make("Desk","ordi");
  static BlueObjet ball2=make("Desk2","ordi2");


  List<BlueObjet> object=[bal,ball,ball2];

  BMGState();

  @override
   static BlueObjet make(String name,String fonction){
    BlueObjet blue=new BlueObjet();
    blue.name=name;
    blue.fonction=fonction;
    return blue;
  }
    void initState() {
    super.initState();
    setupList();
    setupListDayfirst();
    setupListDaysecond();
    setupListDaythird();

  }

  int todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;
  }
  int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;

  }
  int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;

  }
  int todayHours() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('kk').format(now));
    print(formattedTime);
    return formattedTime;
  }
  int todayMin() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('mm').format(now));
    print(formattedTime);
    return formattedTime;

  }
  String today() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('a').format(now);
    print(formattedTime);
    return formattedTime;


  }

  void setupList() async{
    var _blues = await dataBase.fetchAllBlues();
    print(_blues);
    setState(() {
      blues = _blues;
    });
  }
    void setupListDayfirst() async{
    var _bluedayfirst = await dataBase.getBlueDay((todayYear()),(todayMonths()),(todayDay()),object[0].name);
    setState(() {
      bluedayfirst = _bluedayfirst;
    });
  }
      void setupListDaysecond() async{
    var _bluedaysecond = await dataBase.getBlueDay((todayYear()),(todayMonths()),(todayDay()),object[1].name);
    setState(() {
      bluedaysecond = _bluedaysecond;
    });
  }
        void setupListDaythird() async{
    var _bluedaythird = await dataBase.getBlueDay((todayYear()),(todayMonths()),(todayDay()),object[2].name);
    setState(() {
      bluedaythird = _bluedaythird;
    });
  }
  


  Widget build(BuildContext context) {

    
    List<charts.Series<BlueDay, DateTime>> series = withSampleData();

    // The children consist of a Chart and Text widgets below to hold the info.
     return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
      new SizedBox(
          height: 150.0,
          child: new charts.TimeSeriesChart(
            series,
            animate: true,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,

              )
              
            ],
            behaviors: [
            new charts.SeriesLegend(
                position: charts.BehaviorPosition.bottom, desiredMaxRows: object.length)
          ],
            
            
          )
          ),
          
    ]
          )
     );
  }
   withSampleData() {
    return (
      _createSampleData()
    );
  }

    List<charts.Series<BlueDay, DateTime>>   _createSampleData(){

    return [
      new charts.Series<BlueDay, DateTime>(
          id: '${object[0].name}/${object[0].fonction}',
          domainFn: (BlueDay bluedayfirst, _) => DateTime(int.parse(bluedayfirst.theYear),int.parse(bluedayfirst.theMonth),int.parse(bluedayfirst.theDay),int.parse(bluedayfirst.theHour)),
          measureFn: (BlueDay bluedayfirst, _) => bluedayfirst.theTime,

          data: bluedayfirst,


          // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueDay, DateTime>(
          id: '${object[1].name}/${object[1].fonction}',
          domainFn: (BlueDay bluedaysecond, _) => DateTime(int.parse(bluedaysecond.theYear),int.parse(bluedaysecond.theMonth),int.parse(bluedaysecond.theDay),int.parse(bluedaysecond.theHour)),
          measureFn: (BlueDay bluedaysecond, _) => bluedaysecond.theTime,

          data: bluedaysecond,
          // Set a label accessor to control the text of the bar label.
      ),
        new charts.Series<BlueDay, DateTime>(
          id: '${object[2].name}/${object[2].fonction}',
          domainFn: (BlueDay bluedaythird, _) => DateTime(int.parse(bluedaythird.theYear),int.parse(bluedaythird.theMonth),int.parse(bluedaythird.theDay),int.parse(bluedaythird.theHour)),
          measureFn: (BlueDay bluedaythird, _) => bluedaythird.theTime,

          data: bluedaythird,
          // Set a label accessor to control the text of the bar label.
      ),
    ];
  } 
}