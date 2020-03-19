import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/stepsManager.dart';



// revoir comment faire des pas à l'interieur ou exté...
//comment analyser les pas
void main(){
  //DBProvider dbProvider = DBProvider.db;
  //StepsManager stepsManager;
  runApp(MyApp());
}

  
 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
  
  
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = 'unknown';
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  int value = 0;
  List<Steps> steps = [];


  bool resetCounterPressed = false;
  String timeToDisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = Duration(seconds: 1);
  var now = DateTime.now();
  

  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

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
  
  Widget stopWatch(){
    return Container(
      child: Column(
        children:<Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(timeToDisplay,
                  style: TextStyle(fontSize: 20.0),
                  ),
          ),
        ]
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    
    var scaffold = Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.directions_walk),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Step counter: $resetTheCounter ex: $_stepCountValue'),
               ), 
               Divider(),
               Text(DateTime.now().toString()),   
               Text(now.toString()),                   
            ]
            ),
            stopWatch(),
            _buildStepList(steps),
            RaisedButton(
              onPressed: reset,
              child: Text('reset'),
              ),
            RaisedButton(
              onPressed: resetStepCounter,
              child: Text('reset timer'),
            ),
          ],
        ),
        margin: const EdgeInsets.all(8.0),
      ), 
    );
    return scaffold;
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
      //StepsManager(dbProvider).addNewSteps(step);
      //reset();
     // _subscription.resume();

    }
    
    print('saved $value');
  }

 int get resetTheCounter { 
   _save();
   
   if ((swatch.elapsed.inSeconds%60)%10==0){
   var step = new Steps(
        id: null,
        numberSteps: int.parse('$_stepCountValue')-value,
        theTime: timeToDisplay,
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
  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }
 

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  Widget _buildStepList(List<Steps> stepsList) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: stepsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(stepsList[index].id.toString()),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('time'),
                    Text(stepsList[index].theTime),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('nb of steps'),
                    Text(stepsList[index].numberSteps.toString()),
                  ],
                ),
              ),
              
            ],
          );
        },
      ),
    );
  }


  void setupList() async{
    var _steps = await dataBase.fetchAll();
    print(_steps);
    setState(() {
      steps = _steps;
    });
  }



}
