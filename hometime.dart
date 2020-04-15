import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projet_geo/data/database.dart';
import 'package:projet_geo/data/hometimesManager.dart';
import 'package:projet_geo/models/hometimesModel.dart';
import 'widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class HT extends StatefulWidget {

  State createState() => new HTState();
  
 
}

class HTState extends State<HT> {
  final String wifi="192.168.1.16";
  final String wifiname="Livebox-581E";

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  
  
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<HomeTimes> hometimes = [];
  bool resetCounterPressed = false;
  int timeToDisplay = 0;
  var swatch = Stopwatch();
  final dur = Duration(seconds: 1);
  int day= 0;
  int months=0;
  int year=0 ;
  String hours="";
  String min="";
  int part=0;
  bool _changed;
  



   String _monrouteur= "inconnu";
   String _mawifi="inconnu";

  static int todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    String formattedDate = formatter.format(now);
    int day = int.parse(formattedDate);
    print('day : ' +formattedDate);
    return day;
  }

  static int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String formattedDate = formatter.format(now);
    int month = int.parse(formattedDate);
    print('month : ' + formattedDate);
    return month;

  }
  static int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    int year = int.parse(formattedDate);
    print('Year : ' + formattedDate);
    return year;
  }
  String todayHours() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('kk').format(now);
    print('Hours : ' + formattedTime);
    return formattedTime;
  }
  String todayMin() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('mm').format(now);
    print('min : ' + formattedTime);
    return formattedTime;

  }
  int today() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('a').format(now);
    int a = int.parse(formattedTime);
    print(formattedTime);
    return a;
  }
  void starttimer(){
    Timer(dur, keeprunning);
  }
  void keeprunning(){
    if(swatch.isRunning){
      starttimer();
    }
    setState(() {
      timeToDisplay = (swatch.elapsed.inSeconds);
    });  }
    void resetTimeCounter() {
    setState(() {
      resetCounterPressed = false;

    });
    swatch.reset();
    timeToDisplay = 0;
  }
  void test() {
    
    if( _monrouteur==wifi || _mawifi==wifiname){
      swatch.start();
       starttimer();
      keeprunning();
    }
    else if ( (_monrouteur!=wifi || _mawifi != wifiname) && timeToDisplay != 0 ) {
      print(timeToDisplay);
     day=todayDay();
     months=todayMonths();
     year=todayYear();
     hours=todayHours();
     min=todayMin();
     part=today();
    //countTheHomeTimes;


    resetTimeCounter;
          

    }
  }

  /*int get countTheHomeTimes {
   var hometime = new HomeTimes(
        id: null,
        theTime: timeToDisplay,
        theDay : day,
        theMonths : months,
        theYear : year,
        theHours : hours,
        theMin : min,
        thePart : part,
      );
              HometimesManager(dbProvider).addNewHometimes(hometime); 
    return timeToDisplay;
}*/

  void initState() {
    _changed = true;
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
        setupList();
    
  }

  void dispose() {

    _connectivitySubscription.cancel();
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
  
   void setupList() async{
    var _hometimes = await dataBase.fetchAlltimes();
    print(_hometimes);
    setState(() {
      hometimes = _hometimes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  grapheDay(){

  }


  @override
  Widget build(BuildContext context) {
    List<charts.Series<DataDay, String>> data;
    _changed = false;
    if(_changed)
    return new Container(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Acquisition en cours',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), 
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.home),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 20),
                  child:
                     Text('Home time: NULL'),
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

   
                child: 
                  
                Text(
                  'Acquisition',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
                        Text(
                          "Home Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                         new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child:  BuildtimesList().buildList(hometimes),
               ),
              ), 
                        Container(
                          width: 300,
                          height: 200,
                          child: FutureBuilder<List<charts.Series<DataDay, String>>>(
                  future: withDataDay(), // a previously-obtained Future<String> or null
                  builder: (context, snapshot) {
                     if (snapshot.hasData) {
                       data = snapshot.data;
                       return charts.PieChart(data,behaviors: [
        new charts.DatumLegend(
          position: charts.BehaviorPosition.end,
          horizontalFirst: false,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          showMeasures: true,
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          measureFormatter: (num value) {
            return value == null ? '-' : '${value}H';},
        ),
      ],
      );
                    } else if (snapshot.hasError) {
                        return Text(
                    'Error:\n\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  );
        } else {
          return Text('Il n\'y a pas de données');
        }
                   } )
                        )
                          
                      ],
                    
                  ),
                ),
              ), 
                
               ]        
        ),        
      ); 
    }
  }


static Future<List<charts.Series<DataDay, String>>> withDataDay() async {
      return (
      await  _createDataDay()
    );
  }
static Future<List<charts.Series<DataDay, String>>> withDataWeek() async {
      return (
      await  _createDataWeek()
    );
  }
static Future<List<charts.Series<DataDay, String>>> withDataMonth() async {
    return (
    await  _createDataMonth()
  );
}

  static Future <List<charts.Series<DataDay, String>>> _createDataDay() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    DBProvider().initDB();
    var time = await DBProvider().getHomeTimesByDay(y,m,d);
    var timeInHour = time%360;
    var hour = 24-timeInHour;
    final data = [
      new DataDay(time, 'home'),
      new DataDay(hour,'outside'),
    ];
    return [
      new charts.Series<DataDay, String>(
          id: 'wifi',
         // data: DBProvider.getHomeTimesByDay(todayYears(),todayMonth(),todayDay())
          data: data,
          domainFn: (DataDay hometimes, _) => hometimes.location,
          measureFn: (DataDay hometimes, _) => hometimes.time,
      )
    ];
  }

  static Future <List<charts.Series<DataDay, String>>> _createDataWeek() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    DBProvider().initDB();
    var time = await DBProvider().getHomeTimesMean(y,m,d,7);
    var timeInHour = time%360;
    var hour = 24-timeInHour;
    final data = [
      new DataDay(time, 'home'),
      new DataDay(hour,'outside'),
    ];
    return [
      new charts.Series<DataDay, String>(
          id: 'wifi',
         // data: DBProvider.getHomeTimesByDay(todayYears(),todayMonth(),todayDay())
          data: data,
          domainFn: (DataDay hometimes, _) => hometimes.location,
          measureFn: (DataDay hometimes, _) => hometimes.time,
      )
    ];
  }

  static Future <List<charts.Series<DataDay, String>>> _createDataMonth() async {
    int d = todayDay();
    int m = todayMonths();
    int y = todayYear();
    DBProvider().initDB();
    var time = await DBProvider().getHomeTimesMean(y,m,d,30);
    var timeInHour = time%360;
    var hour = 24-timeInHour;
    final data = [
      new DataDay(time, 'home'),
      new DataDay(hour,'outside'),
    ];
    return [
      new charts.Series<DataDay, String>(
          id: 'wifi',
         // data: DBProvider.getHomeTimesByDay(todayYears(),todayMonth(),todayDay())
          data: data,
          domainFn: (DataDay hometimes, _) => hometimes.location,
          measureFn: (DataDay hometimes, _) => hometimes.time,
      )
    ];
  }
 

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;
        

        try { 
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
              _monrouteur=wifiIP;
              _mawifi=wifiName;
              test();


        });
        break;
      case ConnectivityResult.mobile:
      setState(() {
        _connectionStatus = '$result\n'
              'Wifi Name: ""\n'
              'Wifi BSSID: ""\n'
              'Wifi IP: ""\n';
              _monrouteur="";
              _mawifi="";
        });

        test();
        break;


      case ConnectivityResult.none:
        setState(() { _connectionStatus = result.toString();
          _monrouteur="";
          _mawifi="";

         } );
        test();
        break;
      default:
        setState(() { 
          _connectionStatus = 'Failed to get connectivity.';
          _monrouteur="";
          _mawifi="";


        });

        test();
        break;
    }
  }

}


class DataDay {
  final int time;
  final String location;

  DataDay(this.time, this.location);
}