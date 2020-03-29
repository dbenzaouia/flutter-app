import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/database.dart';
import 'package:flutter_app/data/hometimesManager.dart';
import 'package:flutter_app/models/hometimesModel.dart';
import 'widget/list_widget.dart';

class HT extends StatefulWidget {
  //HT({Key key, this.wifi}) : super(key: key);

  //final String wifi;
  State createState() => new HTState();
  
 
}

class HTState extends State<HT> {
  //HTState({Key key, this.wifi});
  final String wifi="inconnu";
  //final _controller = TextEditingController();

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
  var now = DateTime.now();
  int _count=0;
  bool _changed;


   String _monrouteur= "inconnu";

    
  @override
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
    if(_count==1 ){
      swatch.start();
       starttimer();
      keeprunning();
      _count=0;
    }
    else if (_count==0) {
      print(timeToDisplay);
     countTheHomeTimes;
    resetTimeCounter();
          _count=1;

    }
  }
  String get countTheHomeTimes {
   
   
   var hometime = new HomeTimes(
        id: null,
        theTime: timeToDisplay,
      );
              HometimesManager(dbProvider).addNewHometimes(hometime); 
      
   
    return timeToDisplay;
 
}
  void initState() {
    super.initState();
    _changed = true;
   // _controller.addListener(_print);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
        setupList();
    
  }

  void dispose() {
    //_controller.dispose();

    _connectivitySubscription.cancel();
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
  _print(){
    print(wifi);
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
       new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildtimesList().buildList(hometimes),
               ),
              ),  
               ]
                  
        ),
       
        
      );
    
  }
 

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    test();
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

        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

}