import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/data/database.dart';
import 'package:flutter_app/data/stepsManager.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/widget/list_widget.dart';
import 'package:intl/intl.dart';
import 'widget/pedometer_widget.dart';

import 'package:flutter_app/widget/pedometer_widget.dart';



class Pedo extends StatefulWidget {
  PedoState createState() => new PedoState();
  
 
}

class PedoState extends State<Pedo> {
   Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = '0';
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  int value = 0;
  int _changed=0;
  List<Steps> steps = [];
  List<StepsDay> stepsday = [];
  List<StepsDays> stepsdays = [];

  List<StepsMonths> stepsmonths =[];
  List<StepsDays> stepsweek =[];


  int day=0;
  int months=0;
  int year=0;
  String hours="";
  int min=0;
  String part="";
  PedometerWidget pd = new PedometerWidget();
  PedometerWidgetAnnuel pda = new PedometerWidgetAnnuel();
  PedometerWidgetMonths pdm = new PedometerWidgetMonths();
  PedometerWidgetWeek pdw = new PedometerWidgetWeek();





  bool resetCounterPressed = false;
  String timeToDisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = Duration(seconds: 1);
  var now = DateTime.now();
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];


  @override
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
  String todayHours() {
    var now = new DateTime.now();
    String formattedTime = (DateFormat('kk').format(now));
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

   void starttimer(){
    Timer(dur, keeprunning);
  }
  void keeprunning(){
    if(swatch.isRunning){
      starttimer();
    }
    setState(() {
      timeToDisplay = swatch.elapsed.inHours.toString().padLeft(2,"0") + ":"
                      + (swatch.elapsed.inMinutes%60).toString().padLeft(2,"0") + ":"
                      + (swatch.elapsed.inSeconds%60).toString().padLeft(2,"0");
    });
  }
  void resetStepCounter() {
    setState(() {
      resetCounterPressed = false;

    });
    swatch.reset();
    timeToDisplay = "00:00:00";
  }
   
  _save() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    if ((swatch.elapsed.inSeconds%60)%10==0){
      value = int.parse('$_stepCountValue');
      prefs.setInt(key, value);
    }
    
    print('saved $value');
  }

 int get countTheSteps { 
   _save();
   if ((swatch.elapsed.inSeconds%60)%10==0 && (swatch.elapsed.inSeconds%60)!=0){
     day=todayDay();
     months=todayMonths();
     year=todayYear();
     hours= (todayHours());
     print(hours);
     print("l heure ajout $hours");
     min=todayMin();
     part=today();
   var step = new Steps(
        id: null,
        numberSteps: int.parse('$_stepCountValue')-value,
        theTime: timeToDisplay,
        theDay : day,
        theMonths : months,
        theYear : year,
        theHours : hours,
        theMin : min,
        thePart : part,
      );
      if(step.numberSteps != 0){
              StepsManager(dbProvider).addNewSteps(step); 
              
      }
   }
    return int.parse('$_stepCountValue')-value;
 
}
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    
  }

  void initState() {
    //initPlatformState();
    //_changed = 0;
    super.initState();
    startListening();
    setupList();
    setupListDay();
    setupListMonths();
    setupListDays();
    setupListWeek();
  }

  Future<void> initPlatformState() async {
    startListening();
  }
  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void startListening() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

 void stopListening() {
    _subscription.cancel();
  }

  void _onData(int stepCountValue) async {
    setState(() {
       _stepCountValue = "$stepCountValue";
       swatch.start();
       starttimer();
    });
  }
  /*to set the counter to zero, doesn't really work!*/
  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }
 

  void _onDone() => (print("Finished pedometer tracking"));

  void _onError(error) => print("Flutter Pedometer Error: $error");
    

 
 
  void setupList() async{
    var _steps = await dataBase.fetchAll();
    print(_steps);
    setState(() {
      steps = _steps;
    });
  }
  Widget build(BuildContext context) {
     return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Podometre allumé avec nb = $countTheSteps',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), 
                
            ],
          ),
        );

  }
 
 /*Widget build(BuildContext context) {
    List<charts.Series<StepsDay, String>> series = withSampleData();
    List<charts.Series<StepsMonths, String>> seriesmonths = withSampleDatamonths();
    List<charts.Series<StepsDays, String>> seriesdays = withSampleDataDays();
    List<charts.Series<StepsDays, String>> seriesweek = withSampleDataWeek();

    

    

    if(_changed==0)
      return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Acquisition en cours, marchez pendant 30s',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), 
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.directions_walk),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 20),
                  child:
                      Text('Step counter: $countTheSteps'),
                ),
              ],),
            
              RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                     _changed = 1;
                  });
                },
                child: Text(
                  'Graphique journalier',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                     _changed = 4;
                  });
                },
                child: Text(
                  'Graphique hebdomadaire',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
               RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                     _changed = 3;
                  });
                },
                child: Text(
                  'Graphique mensuel',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                    _changed = 2;
                  });
                },
                child: Text(
                  'Graphique annuel',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
    else if (_changed==1){
        return pd.pedometerWidget(50, series,stepsday);
    }
    else if(_changed==2){
        return pda.pedometerWidget(50, seriesmonths,stepsmonths);

    }
      else if(_changed==3){
        return pdm.pedometerWidget(50, seriesdays,stepsdays);

    }
    else if(_changed==4){
        return pdw.pedometerWidget(50, seriesweek,stepsweek);

    }
        /*(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                         RaisedButton(
                onPressed: () {
                  setState(() {
                    _changed ? _changed = false : _changed = true;
                  });
                },
                child: Text(
                  'Acquisition',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
                        Text(
                          "Number of steps",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 300,
                          height: 200,
                          child: charts.BarChart(series, animate: true),
                        ),
                      ],
                    
                  ),
                ),
              ), 
              new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepList(steps),
               ),
              ),   
               ]
                  
        ),
       
        
      );    }*/
  }*/
  void setupListDay() async{
    var _stepsday = await dataBase.getStepsDay(todayYear(),todayMonths(),todayDay());
    print(_stepsday);
    setState(() {
      stepsday = _stepsday;
    });
  }
    void setupListMonths() async{
    var _stepsmonths = await dataBase.getStepsMonths(todayYear());
    print(_stepsmonths);
    setState(() {
      stepsmonths = _stepsmonths;
    });
  }
    void setupListDays() async{
    var _stepsdays = await dataBase.getStepsperDay(todayYear(),todayMonths());
    print(_stepsdays);
    setState(() {
      stepsdays = _stepsdays;
    });
  }
   void setupListWeek() async{
    var _stepsweek = await dataBase.getStepsWeek(todayYear(),todayMonths(),todayDay());
    print(_stepsweek);
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
