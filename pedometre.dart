import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/data/database.dart';
import 'package:flutter_app/data/stepsManager.dart';
import 'package:intl/intl.dart';




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
  


  int day=0;
  int months=0;
  int year=0;
  String hours="";
  int min=0;
  String part="";





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
    return formattedDate;
  }
  int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    int formattedDate = int.parse(formatter.format(now));
    return formattedDate;

  }
  int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    int formattedDate = int.parse(formatter.format(now));
    return formattedDate;

  }
  String todayHours() {
    var now = new DateTime.now();
    String formattedTime = (DateFormat('kk').format(now));
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
    
  }

 int get countTheSteps { 
   _save();
   if ((swatch.elapsed.inSeconds%60)%10==0 && (swatch.elapsed.inSeconds%60)!=0){
     day=todayDay();
     months=todayMonths();
     year=todayYear();
     hours= (todayHours());
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
    super.initState();
    startListening();
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
}
