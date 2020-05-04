import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './../data/database.dart';
import './../data/hometimesManager.dart';
import './../models/hometimesModel.dart';
import '../widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../configModel.dart';


class HT extends StatefulWidget {

  State createState() => new HTState();
  
 
}

class HTState extends State<HT> {


  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  static Config makeinit(){
  Config bla=new Config();
  bla.wifiname="";
  bla.wifiIP="";
  return bla;
}




  List<Config> config=[makeinit()];
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
  String part="";
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
      timeToDisplay = (swatch.elapsed.inSeconds);
    });  }
    void resetTimeCounter() {
    setState(() {
      resetCounterPressed = false;

    });
    swatch.reset();
    swatch.stop();
    timeToDisplay = 0;
  }
  void test() {
    setupconfig();
    print("ici debut");
    print(_monrouteur);
    print(config[0].wifiIP);
    print(_mawifi);
    print(config[0].wifiIP);
    if( _monrouteur==config[0].wifiIP || _mawifi==config[0].wifiname ){
      swatch.start();
       starttimer();
      keeprunning();
    }
    else if ( (_monrouteur!=config[0].wifiIP || _mawifi != config[0].wifiname) && timeToDisplay != 0 ) {
      print(timeToDisplay);
     day=todayDay();
     months=todayMonths();
     year=todayYear();
     hours=todayHours();
     min=todayMin();
     part=today();
    countTheHomeTimes;
    resetTimeCounter;
          

    }
    
    
  }

  int get countTheHomeTimes {
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
}

  void initState() {
    _changed = true;
    super.initState();
    initConnectivity();
     const onehour = const Duration(seconds: 60*5);
    new Timer.periodic(onehour, (Timer t) {
      if(timeToDisplay>0){
      print(timeToDisplay);
      day=todayDay();
      months=todayMonths();
      year=todayYear();
      hours=todayHours();
      min=todayMin();
      part=today();
      countTheHomeTimes;
      resetTimeCounter;
      }
      test();

    });
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
        setupList();
        setupconfig();
    
  }
     void setupconfig() async{
    var _config = await dataBase.fetchAllConfig();
    print(_config);
    setState(() {
      config = _config;
    });
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

  @override
  Widget build(BuildContext context) {
     return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Hometime activé',
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
              _monrouteur="wifiip";
              _mawifi="wifinam";
        });
        test();
        break;


      case ConnectivityResult.none:
        setState(() { _connectionStatus = result.toString();
          _monrouteur="wifiip";
          _mawifi="wifinam";

         } );
        test();
        break;
      default:
        setState(() { 
          _connectionStatus = 'Failed to get connectivity.';
          _monrouteur="wifiip";
          _mawifi="wifinam";


        });
        test();
        break;
    }
    
  }

}


class DataDay {
  final int time;
  final String location;
  DataDay(this.location, this.time);
}

class DataList {
  final int time;
  final DateTime day;
  DataList(this.day, this.time);
}