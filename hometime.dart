import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:app/data/database.dart';
import 'package:app/data/hometimesManager.dart';
import 'package:app/models/hometimesModel.dart';
import 'widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/*class HT extends StatefulWidget {

  State createState() => new HTState();
  
 
}

class HTState extends State<HT> {
  final String wifi="10.214.209.206";
  final String wifiname="SmartCampus";

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  
  
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<HomeTimes> hometimes = [];
  bool resetCounterPressed = false;
  String timeToDisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = Duration(seconds: 1);
  String day="";
  String months="";
  String year="";
  String hours="";
  String min="";
  String part="";
  



   String _monrouteur= "inconnu";
   String _mawifi="inconnu";

    
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
    void resetTimeCounter() {
    setState(() {
      resetCounterPressed = false;

    });
    swatch.reset();
    timeToDisplay = "00:00:00";
  }
  void test() {
    
    if( _monrouteur==wifi || _mawifi==wifiname){
      swatch.start();
       starttimer();
      keeprunning();
    }
    else if ( (_monrouteur!=wifi || _mawifi != wifiname) && timeToDisplay != "00:00:00" ) {
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
  String get countTheHomeTimes {
   
   
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

  @override
  Widget build(BuildContext context) {
    
    List<charts.Series<HomeTimes, String>> data = withSampleData();
    return new Container(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
       new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildtimesList().buildList(hometimes),
               ),
              ),  
              Text(
                          "Temps passé au domicile",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 300,
                          height: 200,
                          child: charts.PieChart(data, animate: true, behaviors: [new charts.DatumLegend()]),
                        ),  
               ]
                  
        ),
       
        
      );
    
  }

  withSampleData() {
    return (
      _createSampleData()
    );
  }

  List<charts.Series<HomeTimes, String>> _createSampleData() {

    return [
      new charts.Series<HomeTimes, String>(
          id: 'wifi',
          data: DBProvider.getHomeTimesByDay(todayYears(),todayMonth(),todayDay())
          data: hometimes,
          domainFn: (HomeTimes hometimes, _) => hometimes.theTime,
          measureFn: (HomeTimes hometimes, _) => hometimes.id,
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

}*/