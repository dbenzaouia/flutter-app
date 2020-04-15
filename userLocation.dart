import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_geolocation/geolocation.dart';
import 'package:geocoder/geocoder.dart' ;
import 'package:geolocator/geolocator.dart'as geolocator;
//import 'package:geolocator/geolocator.dart';
import 'data/database.dart';
import 'package:flutter_app/models/geoModel.dart';
import 'package:flutter_app/data/geolocManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pedometer/pedometer.dart';
import 'package:flutter_app/widget/list_widget.dart';
import 'widget/enableWidget.dart';


class Locations extends StatefulWidget {
  @override
  _LocationsState createState() => new _LocationsState();
}
class _LocationsState extends State<Locations> {
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<StreamSubscription<dynamic>> _subscriptions = [];
  StreamSubscription<LocationResult> _subscription;
  //Stream<geolocator.Position> _geosubscription;
  DateTime times;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String stringtimes;
  bool _isTracking = false;
  List<Geoloc> locations = [];
  Pedometer _pedometer;
  StreamSubscription<int> _subscriptionpedo;
  String _stepCountValue = 'unknown';
  int nbSteps = 0;
  int _subscriptionStartedTimestamp;
  int value = 0;
  int initdistance = 0;
  String myhintkey;
  double latitude = 0;
  double longitude = 0;

  @override
  dispose() {
    super.dispose();
    //_subscription.cancel();
  }
  @override
  void initState(){
    super.initState();
    setupList();
    initPlatformState();
  }
  void setupList() async{
    var _locations = await dataBase.fetchLocationsAll();
    print(_locations);
    setState(() {
      locations = _locations;
    });
  }
  Future<void> initPlatformState() async {
    startListening();
  }
  
  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void startListening() {
    _pedometer = new Pedometer();
    _subscriptionpedo = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void stopListening() {
    _subscription.cancel();
  }

  void _onData(int stepCountValue) async {
    setState(() => _stepCountValue = "$stepCountValue");
  }
  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

   _save(int values) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'myhintkey';
    value = values;
    prefs.setInt(key, value);
    print('saved $value');
  }
  
  _savesteps(int values) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'mystepkey';
    nbSteps = values;
    prefs.setInt(key, nbSteps);
    print('saved step is  $nbSteps');
  }
  _savelat(double values) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'mycoordkey';
    latitude = values;
    prefs.setDouble(key, latitude);
    print('saved latitude  $latitude');
  }

  _savelong(double values) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'mycoordikey';
    longitude = values;
    prefs.setDouble(key, longitude);
    print('saved longitude $longitude');
  }

  _onTogglePressed() {
    if (_isTracking) {
      setState(() {
        _isTracking = false;
      });

      _subscription.cancel();
      _subscription = null;
      times = null;
      stringtimes = null;
      _subscriptionStartedTimestamp = null;
    } else {
      setState(() {
        _isTracking = true;
      });
     
      times = new DateTime.now();
      stringtimes = dateFormat.format(DateTime.now());
      _subscriptionStartedTimestamp = (new DateTime.now().millisecondsSinceEpoch /1000).round();
      _subscription = Geolocation
          .locationUpdates(
        accuracy: LocationAccuracy.best,
        displacementFilter: 0.0,
        inBackground: false,
      )
          .listen((result) async{
            final coordinates = new Coordinates(result.location.latitude,result.location.longitude); 
            var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = addresses.first;
            var location = new Geoloc(
                  id: null,
                  address: '${first.locality}+${first.addressLine}',
                  elapsedTime: dateFormat.format(times),
                  elapsedDuration: ((new DateTime.now().millisecondsSinceEpoch) /1000).round()-
                  _subscriptionStartedTimestamp,
                  diffDuration: 0,
                  distance: 0,
                  coordinates: coordinates.toString(),
                  vitesse: 0,
                  pas: int.parse(_stepCountValue)-nbSteps
                );
            
            GeolocManager(dbProvider).addNewGeoloc(location);
            Geoloc mylocation = await GeolocManager(dbProvider).getLastFetch();
             _save(mylocation.elapsedDuration);
             _savesteps(int.parse(_stepCountValue));
             
            final newlocation = new Geoloc(
               id: mylocation.id,
                address: '${first.locality}+${first.addressLine}',
                elapsedTime: dateFormat.format(times),
                elapsedDuration: ((new DateTime.now().millisecondsSinceEpoch) /1000).round()-
                  _subscriptionStartedTimestamp,
                diffDuration: mylocation.elapsedDuration - value, //difference de temps entre 2 updates de localisation
                distance: 0,
                coordinates: coordinates.toString(),
                vitesse: 0,
                pas: mylocation.pas
              );
              GeolocManager(dbProvider).updateGeoloc(newlocation);
              print('duree ${newlocation.diffDuration}');
               _savelat(coordinates.latitude);
               _savelong(coordinates.longitude);
              // _savesteps(newlocation.pas);
             
            // print('dist is $coordinates and loc ${mylocation.coordinates} and coord sav are $latitude and $longitude');
              double distanceInMeters = await geolocator.Geolocator().distanceBetween(first.coordinates.latitude, first.coordinates.longitude, latitude ,longitude);
              //print('lat 1 ${first.coordinates.latitude} long 1: ${first.coordinates.longitude} lat 2: $latitude long 2 : $longitude  ');
              print('distance is $distanceInMeters ');
             double vitesse = (newlocation.diffDuration == 0 ? 0.0 : distanceInMeters/newlocation.diffDuration );
            final newlocation2 = new Geoloc(
               id: newlocation.id,
                address: '${first.locality}+${first.addressLine}',
                elapsedTime: dateFormat.format(times),
                elapsedDuration: ((new DateTime.now().millisecondsSinceEpoch) /1000).round()-
                  _subscriptionStartedTimestamp,
                diffDuration: newlocation.diffDuration, //difference de temps entre 2 updates de localisation
                distance: distanceInMeters.floor(),
                coordinates: coordinates.toString(),
                vitesse: vitesse.floor(),
                pas: newlocation.pas
              );
              GeolocManager(dbProvider).updateGeoloc(newlocation2);
            //print('distance is $distanceInMeters m. durée : ${newlocation.diffDuration} vitesse $vitesse m/s');
            setState(() {
            locations.insert(locations.length, newlocation2);

        });
      });
                                                     
      _subscription.onDone(() {
        setState(() {
          _isTracking = false;
        });
      });
    }
  }

 /* int get _theSpeed{
    var locationOptions = geolocator.LocationOptions(accuracy : geolocator.LocationAccuracy.best,
                                                        distanceFilter: 10);
      StreamSubscription<geolocator.Position> positionStream = new geolocator.Geolocator().getPositionStream(locationOptions).listen(
    (geolocator.Position position) {
      var speeds = position.speed;
      print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      print('speedy $speeds');
      return speeds;
    });
     
  }*/


  @override
  Widget build(BuildContext context) {
    //_theSpeed();
   List<Widget> children = [
      new _Header(
        isRunning: _isTracking,
        onTogglePressed: _onTogglePressed,
      )
    ];
    children.addAll(ListTile.divideTiles(
      context: context,
      tiles: locations.map((location) => new _Item(data: location)).toList(),
    ));
    return new Container(
      child: new Expanded(child: 
      new ListView(
        children: children,
      ),
      ),
      

      
    );
  }


}
class _Header extends StatelessWidget {
  _Header({@required this.isRunning, this.onTogglePressed});

  final bool isRunning;
  final VoidCallback onTogglePressed;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Center(
        child: new _HeaderButton(
          title: isRunning ? 'Stop' : 'Start',
          color: isRunning ? Colors.deepOrange : Colors.teal,
          onTap: onTogglePressed,
        ),
      ),
    );
  }
}
class _HeaderButton extends StatelessWidget {

  _HeaderButton(
      {@required this.title, @required this.color, @required this.onTap});

  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: new GestureDetector(
        onTap: onTap,
        child: new Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          decoration: new BoxDecoration(
            color: color,
            borderRadius: new BorderRadius.all(
              new Radius.circular(6.0),
            ),
          ),
          child: new Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
class _Item extends StatelessWidget {
  _Item({@required this.data});

  final Geoloc data;

  @override
  Widget build(BuildContext context) {
    String text;
    String status;
    Color color;
      text =
          'id : ${data.id} ${data.vitesse} m/s ${data.diffDuration} s ${data.distance}m , ${data.pas} pas';
      status = 'success';
      color = Colors.green;
    

    final List<Widget> content = <Widget>[
      new Text(
        text,
        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      new SizedBox(
        height: 3.0,
      ),
    ];

    return new Container(
      color: Colors.white,
      child: new SizedBox(
        height: 56.0,
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                ),
              ),
              new Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: new BoxDecoration(
                  color: color,
                  borderRadius: new BorderRadius.circular(6.0),
                ),
                child: new Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}