import 'dart:async';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_geolocation/geolocation.dart';
import 'package:geocoder/geocoder.dart' ;
import 'data/database.dart';
import 'package:flutter_app/models/geoModel.dart';
import 'package:flutter_app/data/geolocManager.dart';
import 'package:flutter_app/widget/list_widget.dart';


class Locations extends StatefulWidget {
  @override
  _LocationsState createState() => new _LocationsState();
}
class _LocationsState extends State<Locations> {
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<StreamSubscription<dynamic>> _subscriptions = [];
  StreamSubscription<LocationResult> _subscription;
  DateTime times;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String stringtimes;
  bool _isTracking = false;
  List<Geoloc> locations = [];

  @override
  dispose() {
    super.dispose();
    _subscription.cancel();
  }
  @override
  void initState(){
    super.initState();
    setupList();
  }
  void setupList() async{
    var _locations = await dataBase.fetchLocationsAll();
    print(_locations);
    setState(() {
      locations = _locations;
    });
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
    } else {
      setState(() {
        _isTracking = true;
      });

      times = new DateTime.now();
      stringtimes = dateFormat.format(DateTime.now());
      _subscription = Geolocation
          .locationUpdates(
        accuracy: LocationAccuracy.best,
        displacementFilter: 0.0,
        inBackground: false,
      )
          .listen((result) async{
            final coordinates = new Coordinates(result.location.latitude,result.location.longitude); 
            print('heyy $coordinates');
            var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = addresses.first;
            final location = new Geoloc(
                  id: null,
                  address: '${first.locality}+${first.addressLine}',
                  elapsedTime: dateFormat.format(times),
                );
            GeolocManager(dbProvider).addNewGeoloc(location);
            Geoloc mylocation = await GeolocManager(dbProvider).getLastFetch();
            print('hello ! ${mylocation.id} ${mylocation.elapsedTime}');
        

        setState(() {
         locations.insert(locations.length, mylocation);
         
        });
      });

      _subscription.onDone(() {
        setState(() {
          _isTracking = false;
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
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
          'id : ${data.id} ${data.address}';
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