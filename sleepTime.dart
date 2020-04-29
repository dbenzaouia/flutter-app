import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/sleepModel.dart';
import 'package:sensors/sensors.dart';
import 'package:light/light.dart';
import 'widget/sleepTrack_widget.dart';
import 'data/database.dart';
import 'data/sleepTimeManager.dart';
import 'widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'hometime.dart';
import 'package:intl/intl.dart';
import 'configModel.dart';






class MytestPage extends StatefulWidget {
  MytestPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MytestPageState createState() => _MytestPageState();
}


class _MytestPageState extends State<MytestPage> {

  final _controller = TextEditingController();
  
  List<double> _accelerometerValues;
  List<double> _gyroscopeValues;
  static Config makeinit(){
  Config bla=new Config();
  bla.wifiname="hjh";
  bla.wifiIP="huh";
  return bla;
}




  List<Config> config=[makeinit()];
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];
  int timeToDisplay = 0;
  final dur = Duration(seconds: 1);
  var swatch = Stopwatch();
  var now = new DateTime.now();
  Duration duree = new Duration(hours:16);
  DateTime startTime;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  int day=0;
  int months=0;
  int year=0;
  String hours="";
  String min="";
  String part="";

  String _luxString = 'Unknown';
  Light _light;
  int _count=0;
  List<SleepTime> sleep = [];
  String _monrouteur= "inconnu";
  String _wifi="inconnu";

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

static int todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    String formattedDate = formatter.format(now);
    int a = int.parse(formattedDate);
    print(formattedDate);
    return a;
  }
  static int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String formattedDate = formatter.format(now);
    int a = int.parse(formattedDate);
    print(formattedDate);
    return a;

  }
  static int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    int a = int.parse(formattedDate);
    print(formattedDate);
    return a;

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
  static String today() {
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
      timeToDisplay = (swatch.elapsed.inSeconds);
    });
  }

 

 
  void startChrono() {
    setState(() {
      if (swatch.isRunning) {
        print("time is ${swatch.elapsedMilliseconds}");
      } else {
        print("time here is ${swatch.elapsedMilliseconds}");
        swatch.reset();
        swatch.start();
      }
    });
  }

  void stopChrono() {
    setState(() {
      if (swatch.isRunning) {
        swatch.stop();
        timeToDisplay=0;
      }
    });
  }



    
  @override
  void initState() {
    super.initState();
     _controller.addListener(_print);
    initPlatformState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
              });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
              });
    }));
    setupList();
    setupconfig();
    //_chrono();
    
  }
  void setupList() async{
    var _sleep = await dataBase.fetchSleepAll();
    print(_sleep);
    setState(() {
      sleep = _sleep;
    });
  }
  setupconfig();

  _chrono(){
    /*print("ici debut sleep");
    print(_monrouteur);
    print(config[0].wifiIP);
    print(_wifi);
    print(config[0].wifiname);*/

    if(_count==0 && config.length>0){
    if( (_wifi==config[0].wifiname ||_monrouteur==config[0].wifiIP) && timeToDisplay==0 && int.parse(_luxString)<5 && 
    (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])<10.5 && 
    (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])>9.0 && 
    (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])<0.1 && 
    (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])>(-0.1) &&
     (_accelerometerValues[0] > 9.5 || _accelerometerValues[1]>9.5 || _accelerometerValues[2] > 9.5) /*&&
      (now.isAfter(startTime))*/){
      _count=1;
      print(now.hour);
      print('you re sleeping $startTime');
      startChrono();

    }
    }
    else if (config.length>0){
      if((_monrouteur!=config[0].wifiIP && _wifi != config[0].wifiIP) || int.parse(_luxString)>5|| 
      (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])>10.5 ||
       (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])<9.0 || 
       (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])>0.1 || 
       (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])<(-0.1)){
         if(timeToDisplay>0){
      _count=0;
    day=todayDay();
     months=todayMonths();
     year=todayYear();
     hours=todayHours();
     min=todayMin();
     part=today();
      sleepTimer;
      print('nooo');
      stopChrono();
         }
         else{
           print("ici");
         }

    }
    }
    
    
  }
  int get sleepTimer{
     var sleepTime = new SleepTime(
        id: null,
        duration: timeToDisplay,
        theDay : day,
        theMonths : months,
        theYear : year,
        theHours : hours,
        theMin : min,
        thePart : part,
      );
      print('i saved id!!');
      SleepTimeManager(dbProvider).addNewSleepTime(sleepTime); 
    return timeToDisplay;
  }

  void dispose() {
    _controller.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
  _print(){
    print(_controller.text);
  }
     void setupconfig() async{
    var _config = await dataBase.fetchAllConfig();
    print(_config);
    setState(() {
      config = _config;
    });
  }

 
  void _onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
        _chrono();
        starttimer();
     
    });
  }
  void _onDone() {}

  void _onError(error) {}

    Future<void> initPlatformState() async {
    _light = new Light();
    _light.lightSensorStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
      
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
              _wifi=wifiName;
              setupconfig();

              _chrono();


        });
        break;
      case ConnectivityResult.mobile:
      setState(() {
        _connectionStatus = '$result\n'
              'Wifi Name: ""\n'
              'Wifi BSSID: ""\n'
              'Wifi IP: ""\n';
              _monrouteur="wifip";
              _wifi="wifin";
        });
        setupconfig();

        _chrono();
        break;


      case ConnectivityResult.none:
        setState(() { _connectionStatus = result.toString();
          _monrouteur="wifip";
          _wifi="wifin";

         } );
        setupconfig();

        _chrono();
        break;
      default:
        setState(() { 
          _connectionStatus = 'Failed to get connectivity.';
          _monrouteur="wifip";
          _wifi="wifin";


        });
        setupconfig();

        _chrono();
        break;
    }
  }

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

    @override
   Widget build(BuildContext context) {
     return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Sleeptime activé',
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

 class DataDay {
  final int time;
  final String hour;
  DataDay(this.hour, this.time);
}

class DataListS {
  final int time;
  final DateTime day;
  DataListS(this.day, this.time);
}