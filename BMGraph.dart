
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/blue_widget.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_app/data/database.dart';
import 'package:flutter_app/data/BlueManager.dart';
import 'package:flutter_app/models/blueModel.dart';
import 'package:flutter_app/widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'models/ObjectDisplay.dart';



class BMG extends StatefulWidget {


  BMGState createState() => new BMGState();
  
 
}



enum Types { rien,journalier, hebdomadaire, mensuel,annuel }


class BMGState extends State<BMG> {
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<Blue> blues = [];

  List<BlueDay> bluedayfirst = [];

  List<BlueDay> bluedaysecond = [];
  List<BlueDay> bluedaythird = [];
  List<BlueWeek> blueweekfirst;
  List<BlueWeek> blueweekthird;
  List<BlueWeek> blueweeksecond;
  List<BlueMonths> bluemonthsfirst;
  List<BlueMonths> bluemonthsthird;
  List<BlueMonths> bluemonthssecond;
  List<BlueYear> blueyearfirst;
  List<BlueYear> blueyearthird;
  List<BlueYear> blueyearsecond;



  int _changed=0;
  Types _chang = Types.rien;

  BlueWidgetDay Bday=BlueWidgetDay();
  BlueWidgetYear Byear=BlueWidgetYear();
  BlueWidgetMonths Bmonth=BlueWidgetMonths();
  BlueWidgetWeek Bweek=BlueWidgetWeek();








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
    setupListDay();
    setupListWeek();
    setupListMonths();
    setupListYear();


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


    void setupListDay() async{
    var _bluedayfirst = await dataBase.getBlueDay((todayYear()),(todayMonths()),(todayDay()),object[0].name);

    var _bluedaysecond = await dataBase.getBlueDay((todayYear()),(todayMonths()),(todayDay()),object[1].name);

    var _bluedaythird = await dataBase.getBlueDay((todayYear()),(todayMonths()),(todayDay()),object[2].name);
    setState(() {
      bluedaythird = _bluedaythird;
      bluedaysecond = _bluedaysecond;
      bluedayfirst = _bluedayfirst;


    });
  }
  void setupListWeek() async{

    var _blueweekfirst = await dataBase.getBlueWeek((todayYear()),(todayMonths()),(todayDay()),object[0].name);
    var _blueweeksecond = await dataBase.getBlueWeek((todayYear()),(todayMonths()),(todayDay()),object[1].name);
    var _blueweekthird = await dataBase.getBlueWeek((todayYear()),(todayMonths()),(todayDay()),object[2].name);


    setState(() {
      blueweekthird = _blueweekthird;
      blueweeksecond = _blueweeksecond;
      blueweekfirst = _blueweekfirst;


    });
              
    
  }
    void setupListMonths() async{
    var _bluemonthsfirst = await dataBase.getBlueMonths((todayYear()),object[0].name);
    var _bluemonthssecond = await dataBase.getBlueMonths((todayYear()),object[1].name);
    var _bluemonthsthird = await dataBase.getBlueMonths((todayYear()),object[2].name);


    setState(() {
      bluemonthsthird = _bluemonthsthird;
      bluemonthssecond = _bluemonthssecond;
      bluemonthsfirst = _bluemonthsfirst;


    });
              
    
  }
      void setupListYear() async{
    var _blueyearfirst = await dataBase.getBlueYear((todayYear()),object[0].name);
    var _blueyearsecond = await dataBase.getBlueYear((todayYear()),object[1].name);
    var _blueyearthird = await dataBase.getBlueYear((todayYear()),object[2].name);


    setState(() {
      blueyearthird = _blueyearthird;
      blueyearsecond = _blueyearsecond;
      blueyearfirst = _blueyearfirst;


    });
              
    
  }
  


  Widget build(BuildContext context) {

    
    List<charts.Series<BlueDay, DateTime>> series = withSampleData();
    List<charts.Series<BlueWeek, String>> seriesweek = withSampleDataWeek();
    List<charts.Series<BlueMonths, String>> seriesmonths = withSampleDataMonths();
    List<charts.Series<BlueYear, String>> seriesyear = withSampleDataYear();




    // The children consist of a Chart and Text widgets below to hold the info.
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
            ListTile(
              title: const Text('annuel'),
              leading: Radio(
              value: Types.annuel,
              groupValue: _chang,

              onChanged: (Types value) {
               setState(() { 
                  _chang = value; 
                  _changed=4;
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
     return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
            Bday.BlueWidget(series,bluedayfirst,bluedaysecond,bluedaythird, object)
    ]
          )
     );
  }
  else if(_changed==2){
  return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
      Bweek.BlueWidget(seriesweek, blueweekfirst, blueweeksecond, blueweekthird, object)
    ]
          )
     );

  }
  else if(_changed==3){
    return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
            Bmonth.BlueWidget(seriesmonths, bluemonthsfirst, bluemonthssecond, bluemonthsthird, object)
      
          
    ]
          )
     );

  }
  else if(_changed==4){
    return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
            Byear.BlueWidget(seriesyear, blueyearfirst, blueyearsecond, blueyearthird, object)
      
          
    ]
          )
     );

  }
  }
   withSampleData() {
    return (
      _createSampleData()
    );
  }
     withSampleDataWeek() {
    return (
      _createSampleDataWeek()
    );
  }
       withSampleDataMonths() {
    return (
      _createSampleDataMonths()
    );
  }
         withSampleDataYear() {
    return (
      _createSampleDataYear()
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

List<charts.Series<BlueWeek, String>>   _createSampleDataWeek(){

    return [
      new charts.Series<BlueWeek, String>(
          id: '${object[0].name}/${object[0].fonction}',
          domainFn: (BlueWeek blueweekfirst, _) => blueweekfirst.beginDate+"-"+blueweekfirst.endDate,
          measureFn: (BlueWeek blueweekfirst, _) => blueweekfirst.theTime,

          data: blueweekfirst,


          // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueWeek, String>(
          id: '${object[1].name}/${object[1].fonction}',
          domainFn: (BlueWeek blueweeksecond, _) => blueweeksecond.beginDate+"-"+blueweeksecond.endDate,
          measureFn: (BlueWeek blueweeksecond, _) => blueweeksecond.theTime,

          data: blueweeksecond,
          // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueWeek, String>(
          id: '${object[2].name}/${object[2].fonction}',
          domainFn: (BlueWeek blueweekthird, _) => blueweekthird.beginDate+"-"+blueweekthird.endDate,
          measureFn: (BlueWeek blueweekthird, _) => blueweekthird.theTime,

          data: blueweekthird,
          // Set a label accessor to control the text of the bar label.
      ),
    ];
  } 
  List<charts.Series<BlueMonths, String>>   _createSampleDataMonths(){

    return [
      new charts.Series<BlueMonths, String>(
          id: '${object[0].name}/${object[0].fonction}',
          domainFn: (BlueMonths bluemonthsfirst, _) => bluemonthsfirst.theMonths,
          measureFn: (BlueMonths bluemonthsfirst, _) => bluemonthsfirst.theTime,

          data: bluemonthsfirst,


          // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueMonths, String>(
          id: '${object[1].name}/${object[1].fonction}',
          domainFn: (BlueMonths bluemonthssecond, _) => bluemonthssecond.theMonths,
          measureFn: (BlueMonths bluemonthssecond, _) => bluemonthssecond.theTime,

          data: bluemonthssecond,
          // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueMonths, String>(
          id: '${object[2].name}/${object[2].fonction}',
          domainFn: (BlueMonths bluemonthsthird, _) => bluemonthsthird.theMonths,
          measureFn: (BlueMonths bluemonthsthird, _) => bluemonthsthird.theTime,

          data: bluemonthsthird,
          // Set a label accessor to control the text of the bar label.
      ),
    ];
  } 
   List<charts.Series<BlueYear, String>>   _createSampleDataYear(){

    return [
      new charts.Series<BlueYear, String>(
          id: '${object[0].name}/${object[0].fonction}',
          domainFn: (BlueYear blueyearfirst, _) => blueyearfirst.theYear,
          measureFn: (BlueYear blueyearfirst, _) => blueyearfirst.theTime,

          data: blueyearfirst,


          // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueYear, String>(
          id: '${object[1].name}/${object[1].fonction}',
          domainFn: (BlueYear blueyearsecond, _) => blueyearsecond.theYear,
          measureFn: (BlueYear blueyearsecond, _) => blueyearsecond.theTime,

          data: blueyearsecond,
          // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueYear, String>(
          id: '${object[2].name}/${object[2].fonction}',
          domainFn: (BlueYear blueyearthird, _) => blueyearthird.theYear,
          measureFn: (BlueYear blueyearthird, _) => blueyearthird.theTime,

          data: blueyearthird,
          // Set a label accessor to control the text of the bar label.
      ),
    ];
  } 
}

