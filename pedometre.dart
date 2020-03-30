import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/models/stepsModel.dart';
import 'package:app/data/database.dart';
import 'package:app/data/stepsManager.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:app/widget/list_widget.dart';
import 'package:intl/intl.dart';

//import 'package:flutter_app/widget/pedometer_widget.dart';



class Pedo extends StatefulWidget {
  PedoState createState() => new PedoState();
  
 
}

class PedoState extends State<Pedo> {
   Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = 'unknown';
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  int value = 0;
  bool _changed;
  List<Steps> steps = [];
    String day="";
  String months="";
  String year="";
  String hours="";
  String min="";
  String part="";


  bool resetCounterPressed = false;
  String timeToDisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = Duration(seconds: 1);
  var now = DateTime.now();
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];


  @override
  String todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    return formattedDate;
  }
  String todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    return formattedDate;

  }
  String todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    return formattedDate;

  }
  String todayHours() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('kk').format(now);
    print(formattedTime);
    return formattedTime;
  }
  String todayMin() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('mm').format(now);
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
     hours=todayHours();
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
    _changed = true;
    super.initState();
    startListening();
    setupList();
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
    List<charts.Series<Steps, String>> series = withSampleData();
    if(_changed)
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
                    _changed ? _changed = false : _changed = true;
                  });
                },
                child: Text(
                  'Graphique',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
    else{
        return new Container(
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
       
        
      );    }
  }

  withSampleData() {
    return (
      _createSampleData()
    );
  }

  List<charts.Series<Steps, String>> _createSampleData() {

    return [
      new charts.Series<Steps, String>(
          id: 'Steps',
          domainFn: (Steps steps, _) => steps.theTime,
          measureFn: (Steps steps, _) => steps.numberSteps,
          data: steps,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (Steps steps, _) =>
              '${steps.numberSteps.toString()} pas')
    ];
  } 
}