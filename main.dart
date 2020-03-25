<<<<<<< HEAD
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'pedometre.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Pedometer Demo Home Page'),
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
  _MyHomePageState({Key key});

  @override


  Widget build(BuildContext context) {
        return Scaffold(
      resizeToAvoidBottomPadding: false ,
      appBar: AppBar(
        title: const Text('Flutter app'),
      ),
      body: SingleChildScrollView(
      //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
       child : new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[ 
              new Pedo(),
          ],
          
      ),
      ),
    );
  }
 

}
=======
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/stepsManager.dart';
import 'package:synchronized/synchronized.dart';

// revoir comment faire des pas à l'interieur ou exté...
//comment analyser les pas
void main() {
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
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  int value = 0;
  List<Steps> steps = [];
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = 'unknown';

  bool resetCounterPressed = false;
  String timeToDisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = Duration(seconds: 1);
  var now = DateTime.now();
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  bool _changed;
  List<charts.Series<Steps, String>> series;

  @override
  int get resetTheCounter {
    _save();

    if ((swatch.elapsed.inSeconds % 60) % 10 == 0) {
      var step = new Steps(
        id: null,
        numberSteps: int.parse('$_stepCountValue') - value,
        theTime: timeToDisplay,
      );

      if (step.numberSteps != 0) {
        StepsManager(dbProvider).addNewSteps(step);
        print('id is ${step.id}');
        print(step.theTime);
        print('number of steps is : ${step.numberSteps}');
        //print('${StepsManager(dbProvider).getIdSteps(1)}');

      }
    }
    return int.parse('$_stepCountValue') - value;
  }

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      timeToDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    if ((swatch.elapsed.inSeconds % 60) % 10 == 0 &&
        (swatch.elapsed.inSeconds >= 0)) {
      value = int.parse('$_stepCountValue');
      prefs.setInt(key, value);
      //StepsManager(dbProvider).addNewSteps(step);
      //reset();
      // _subscription.resume();

    }

    print('saved $value');
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

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  void setupList() async {
    var _steps = await dataBase.fetchAll();
    print(_steps);
    setState(() {
      steps = _steps;
    });
  }

  List<charts.Series<Steps, String>> _createSampleData() {
    return [
      new charts.Series<Steps, String>(
          id: 'Sales',
          measureFn: (Steps sales, _) => sales.numberSteps,
          domainFn: (Steps sales, _) => sales.theTime,
          data: steps,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (Steps sales, _) =>
              '${sales.numberSteps.toString()} pas')
    ];
  }


  Widget _buildStepList(steps) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: steps.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(steps[index].id.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('time'),
                    Text(steps[index].theTime),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('nb of steps'),
                    Text(steps[index].numberSteps.toString()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    if (_changed)
      return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child:
                    Text('Step counter: $resetTheCounter ex: $_stepCountValue'),
              ),
              Center(
                child: Text(
                  'Acquisition en cours, marchez pendant 30s',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    else {

       
       List<charts.Series<Steps, String>> series = _createSampleData();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Nombre de pas",
                                style: Theme.of(context).textTheme.body2,
                              ),
                              Container(
                                width: 200,
                                height: 200,
                                child: charts.BarChart(series, animate: true),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              new RepaintBoundary(
                child: new SizedBox(
                  height: 192.0,
                  child: _buildStepList(steps),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
>>>>>>> 95be933528873a3afbcc51773040e71fbf49b352
