import 'dart:async';
import 'dart:typed_data';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as location;
import 'package:fluster/fluster.dart';
import 'map_marker.dart';
import 'map_helper.dart';

class LocationMap extends StatefulWidget {
  @override
  State<LocationMap> createState() => LocationMapState();
}

class LocationMapState extends State<LocationMap> {
  
  final Completer<GoogleMapController> _mapController = Completer();
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

  GoogleMapController _controller;
  StreamSubscription _locationSubscription;
  location.Location _locationTracker = location.Location();
  Marker marker;
  Geoloc geoloc = Geoloc();
   final Set<Marker> _markers = Set();
    /// Minimum zoom at which the markers will cluster
  final int _minClusterZoom = 0;

  /// Maximum zoom at which the markers will cluster
  final int _maxClusterZoom = 19;

  /// [Fluster] instance used to manage the clusters
  Fluster<MapMarker> _clusterManager;
  /// Current map zoom. Initial zoom will be 15, street level
  double _currentZoom = 15;

  /// Map loading flag
  bool _isMapLoading = true;

  /// Markers loading flag
  bool _areMarkersLoading = true;

  /// Url image used on normal markers
  final String _markerImageUrl =
      'https://img.icons8.com/office/80/000000/marker.png';

  /// Color of the cluster circle
  final Color _clusterColor = Colors.blue;

  /// Color of the cluster text
  final Color _clusterTextColor = Colors.white;
  List<LatLng> _markerLocations = []; //A DEFINIR
  List<String> mylatlnglist = [];
  
  
  /*Future<List> get listLatitude async {
            Map list = await GeolocManager(dbProvider).getLatitude();
    return list;
  }*/
  Future<List> get listLongitude async {
            List list = await GeolocManager(dbProvider).getLongitude();
    return list;
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(44.7949647, -0.6214703),
    zoom: 14.4746,
  );
   
  @override
  void initState(){
    super.initState();
    setupList();
    initPlatformState();
  }
  void setupList() async{
    var _locations = await dataBase.fetchLocationsAll();
    //print(_locations);
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
                  lat: coordinates.latitude,
                  long: coordinates.longitude,
                  vitesse: 0,
                  pas: int.parse(_stepCountValue)-nbSteps,
                  pasParMetre: 0,
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
                lat: coordinates.latitude,
                long: coordinates.longitude,
                vitesse: 0,
                pas: mylocation.pas,
                pasParMetre: 0
              );
              GeolocManager(dbProvider).updateGeoloc(newlocation);
              print('duree ${newlocation.diffDuration}');
               _savelat(coordinates.latitude);
               _savelong(coordinates.longitude);
              // _savesteps(newlocation.pas);
             
            // print('dist is $coordinates and loc ${mylocation.coordinates} and coord sav are $latitude and $longitude');
              double distanceInMeters = await geolocator.Geolocator().distanceBetween(coordinates.latitude, coordinates.longitude, latitude ,longitude);
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
                lat: coordinates.latitude,
                long: coordinates.longitude,
                vitesse: vitesse.floor(),
                pas: newlocation.pas,
                pasParMetre: (newlocation.pas/distanceInMeters).floor()
              );
              GeolocManager(dbProvider).updateGeoloc(newlocation2);
              LatLng latlng = LatLng(newlocation2.lat,newlocation2.long);
            //print('distance is $distanceInMeters m. pas : ${newlocation2.pas} ppm ${newlocation2.pasParMetre} m/s');
             // _markerLocations.add(latlng);
              
            
            //print('listy ${_markerLocations.toString()}');
          //  updateMarker(latlng, newlocation2.id);
            setState(() {
              //if(newlocation2.distance>50){
            locations.insert(locations.length, newlocation2);
             _markerLocations.add(latlng);
             _initMarkers();
            //updateMarker(latlng(newlocation2.lat, newlocation2.long), int id )
             // }

        });
      });
                                                     
      _subscription.onDone(() {
        setState(() {
          _isTracking = false;
        });
      });
    }
  }

   Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/locIcon.jpg");
    return byteData.buffer.asUint8List();
  }
   void updateMarkerAndCircle(location.LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId(newLocalData.toString()),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarker);
    });
  }
  /*void updateMarker(LatLng latlng, int id ){
    print('im updating marker');
    this.setState(() {
          marker = Marker(
              markerId: MarkerId(id.toString()),
              position: latlng,
              //rotation: newLocalData.heading,
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5),
              icon: BitmapDescriptor.defaultMarker);
        });
  }*/
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    /*setState(() {
      _isMapLoading = false;
    });*/

    _initMarkers();
  }
  void _initMarkers() async {
    final List<MapMarker> markers = [];
    List<Map> latlist = await GeolocManager(dbProvider).getLatitude();
   // print('yoyoyoy ${mylatlnglist.toString()}');
    List longlist = await GeolocManager(dbProvider).getLongitude();
    for (var i =0; i<latlist.length; i++){
      //latlist.forEach((k) {print(k.values); });
     // double into = double.parse(latlist[i].values.toString());
      //double inti = double.parse(longlist[i].values.toString());
      //print('toto $into $inti');
      //_markerLocations.add(LatLng(into,inti));
    }
    print('marker iiiis ${_markerLocations.toString()}');
    
    for (LatLng markerLocation in _markerLocations) {
      //final BitmapDescriptor markerImage =
        //  await MapHelper.getMarkerImageFromUrl(_markerImageUrl);
      print('in initmarker we hve $markerLocation');
      markers.add(
        MapMarker(
          id: _markerLocations.indexOf(markerLocation).toString(),
          position: markerLocation,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }
     _clusterManager = await MapHelper.initClusterManager(
      markers,
      _minClusterZoom,
      _maxClusterZoom,
    );

    await _updateMarkers();
  }
  /// Gets the markers and clusters to be displayed on the map for the current zoom level and
  /// updates state.
  Future<void> _updateMarkers([double updatedZoom]) async {
    if (_clusterManager == null || updatedZoom == _currentZoom) return;

    if (updatedZoom != null) {
      _currentZoom = updatedZoom;
    }

    setState(() {
      _areMarkersLoading = true;
    });

    final updatedMarkers = await MapHelper.getClusterMarkers(
      _clusterManager,
      _currentZoom,
      _clusterColor,
      _clusterTextColor,
      80,
    );
 _markers
     // ..clear()
      ..addAll(updatedMarkers);

    setState(() {
      _areMarkersLoading = false;
    });
  }
  /*void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }*/
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new _Header(
            isRunning: _isTracking,
            onTogglePressed: _onTogglePressed,),
          Container(
            height:300.0,
            width: 450.0,
            child:GoogleMap(
              mapToolbarEnabled: false,
              initialCameraPosition: _kGooglePlex,
              markers: _markers,
              onMapCreated: (controller) => _onMapCreated(controller),
              onCameraMove: (position) => _updateMarkers(position.zoom),
            ),
           ),
          FlatButton(
            onPressed: _initMarkers,
            child: Text('click')
          ),
         /* new _Header(
        isRunning: _isTracking,
        onTogglePressed: _onTogglePressed,
      ),*/
        ],
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

 