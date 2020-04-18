
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
  static BlueObjet bal=make("X8","media");
  static BlueObjet ball=make("DESKTOP-0C0N5KJ","ordi");

  List<BlueObjet> object=[bal,ball];

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
  


  Widget build(BuildContext context) {
    List<charts.Series<Blue, DateTime>> series = withSampleData();

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

    List<charts.Series<Blue, DateTime>>   _createSampleData(){

    return [
      new charts.Series<Blue, DateTime>(
          id: '${object[0].name}',
          domainFn: (Blue blues, _) => DateTime(blues.theYear,blues.theMonths,blues.theDay,int.parse(blues.theHours)),
          measureFn: (Blue blues, _) => blues.theTime,

          data: blues,


          // Set a label accessor to control the text of the bar label.
      ),
      charts.Series<Blue, DateTime>(
          id: '${object[1].name}',
          domainFn: (Blue blues, _) => DateTime(blues.theYear,blues.theMonths,blues.theDay,int.parse(blues.theHours)),
          measureFn: (Blue blues, _) => blues.theTime+blues.theTime,
          data: blues,
          // Set a label accessor to control the text of the bar label.
      ),
    ];
  } 
}