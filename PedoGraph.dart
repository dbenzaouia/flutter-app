import 'package:flutter/material.dart';
import 'models/stepsModel.dart';
import 'data/database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'widget/pedometer_widget.dart';
import 'models/ObjectDisplay.dart';

import 'widget/pedometer_widget.dart';




class PedoGraph extends StatefulWidget {
    PedoGraphState createState() => new PedoGraphState();
}
enum Types { rien,journalier, hebdomadaire, mensuel,annuel }

class PedoGraphState extends State<PedoGraph> {

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<Steps> steps = [];
  List<StepsDay> stepsday = [];
  List<StepsDays> stepsdays = [];
  List<StepsMonths> stepsmonths =[];
  List<StepsDays> stepsweek =[]; 


  int day=0;
  int months=0;
  int year=0;
  int hours=0;
  int min=0;
  String part="";
  int _changed=0;
  PedometerWidget pd = new PedometerWidget();
  PedometerWidgetAnnuel pda = new PedometerWidgetAnnuel();
  PedometerWidgetMonths pdm = new PedometerWidgetMonths();
  PedometerWidgetWeek pdw = new PedometerWidgetWeek();

  @override
  String todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    var formattedDate = (formatter.format(now));
    return formattedDate;
  }
  String todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    var formattedDate = (formatter.format(now));
    return formattedDate;

  }
  String todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = (formatter.format(now));
    return formattedDate;

  }
  int todayHours() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('kk').format(now));
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
    setupList();
    setupListDay();
    setupListMonths();
    setupListDays();
    setupListWeek();    
  }

 
    

 
  void setupList() async{
    var _steps = await dataBase.fetchAll();
    setState(() {
      steps = _steps;
    });
  }

 Widget build(BuildContext context) {
    List<charts.Series<StepsDay, String>> series = withSampleData();
    List<charts.Series<StepsMonths, String>> seriesmonths = withSampleDatamonths();
    List<charts.Series<StepsDays, String>> seriesdays = withSampleDataDays();
    List<charts.Series<StepsDays, String>> seriesweek = withSampleDataWeek();
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
        return pd.pedometerWidget(50, series,stepsday);
      }
  else if(_changed==4){
        return pda.pedometerWidget(50, seriesmonths,stepsmonths);

      }
  else if(_changed==3){
        return pdm.pedometerWidget(50, seriesdays,stepsdays);
      }
  else if(_changed==2){
        return pdw.pedometerWidget(50, seriesweek,stepsweek);
    }

  }
  void setupListDay() async{
    var _stepsday = await dataBase.getStepsDay(int.parse(todayYear()),int.parse(todayMonths()),int.parse(todayDay()));
    setState(() {
      stepsday = _stepsday;
    });
  }
  void setupListMonths() async{
      
    var _stepsmonths = await dataBase.getStepsMonths(int.parse(todayYear()));
    setState(() {
      stepsmonths = _stepsmonths;
    });
  }
    

  void setupListDays() async{
    var _stepsdays = await dataBase.getStepsperDay(int.parse(todayYear()),int.parse(todayMonths()));
    setState(() {
      stepsdays = _stepsdays;
    });
  }
  void setupListWeek() async{
    var _stepsweek = await dataBase.getStepsWeek(int.parse(todayYear()),int.parse(todayMonths()),int.parse(todayDay()));
    setState(() {
      stepsweek = _stepsweek;
    });
  }

  withSampleData() {
    return (
      _createSampleData()
    );
  }
  withSampleDataDays(){
    return (
      _createSampleDataDays()
    );
  }
  withSampleDatamonths() {
    
    return (
      _createSampleDatamonths()
    );
  }
  withSampleDataWeek() {
    
    return (
      _createSampleDataWeek()
    );
  }
  List<charts.Series<StepsDays, String>>   _createSampleDataDays(){

    return [
      new charts.Series<StepsDays, String>(
          id: 'StepsDays',
          domainFn: (StepsDays stepsdays, _) => stepsdays.theDay,
          measureFn: (StepsDays stepsdays, _) => stepsdays.numberSteps,
          data: stepsdays,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsDays stepsdays, _) =>
          '${stepsdays.numberSteps.toString()} pas'),     
    ];
  } 
   List<charts.Series<StepsDays, String>>   _createSampleDataWeek(){

    return [
      new charts.Series<StepsDays, String>(
          id: 'StepsWeek',
          domainFn: (StepsDays stepsweek, _) => stepsweek.theDay,
          measureFn: (StepsDays stepsweek, _) => stepsweek.numberSteps,
          data: stepsweek,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsDays stepsweek, _) =>
          '${stepsweek.numberSteps.toString()} pas'),     
    ];
  } 

  List<charts.Series<StepsDay, String>> _createSampleData() {

    return [
      new charts.Series<StepsDay, String>(
          id: 'StepsDay',
          domainFn: (StepsDay stepsday, _) => stepsday.theHour,
          measureFn: (StepsDay stepsday, _) => stepsday.numberSteps,
          data: stepsday,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsDay stepsday, _) =>
          '${stepsday.numberSteps.toString()} pas'),     
    ];
  } 
    List<charts.Series<StepsMonths, String>> _createSampleDatamonths() {

    return [
      new charts.Series<StepsMonths, String>(
          id: 'StepsMonths',
          domainFn: (StepsMonths stepsmonths, _) => stepsmonths.theMonths,
          measureFn: (StepsMonths stepsmonths, _) => stepsmonths.numberSteps,
          data: stepsmonths,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsMonths stepsmonths, _) =>
          '${stepsmonths.numberSteps.toString()} pas'),     
    ];
  }
}
