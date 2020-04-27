import 'dart:async';
import 'dart:typed_data';
//import 'package:geolocator/geolocator.dart';
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
import 'models/pinData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';


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
  geolocator.Position position;
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
  
  int _child = 0;

  PinData _currentPinData = PinData(
    id: null,
    locationName: '',
    activity: '',
  );
  PinData _sourcePinData;
  double _pinPillPosition = -100;


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
    getPermission();

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
                  address: '${first.addressLine}',
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
            //print('distance is $distanceInMeters m. pas : ${newlocation2.pas} ppm ${newlocation2.pasParMetre} m/s');
              
            
           if(mounted){
            setState(() {
            locations.insert(locations.length, newlocation2);
            });
           }
      });
                                                     
      _subscription.onDone(() {
        stopListening();
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
 
 
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    /*setState(() {
      _isMapLoading = false;
    });*/

    _initMarkers();
  }

  void _initMarkers() async {
    final List<MapMarker> markers = [];
    List<num> latlist = await GeolocManager(dbProvider).getLatitude();
    List<num> longlist = await GeolocManager(dbProvider).getLongitude();
    for (var i =0; i<latlist.length; i++){
      double into = latlist[i].toDouble();
      double inti = longlist[i].toDouble();
      _markerLocations.add(LatLng(into,inti));
    }
    
    for (LatLng markerLocation in _markerLocations) {
      //final BitmapDescriptor markerImage =
        //  await MapHelper.getMarkerImageFromUrl(_markerImageUrl);
      Geoloc data = await GeolocManager(dbProvider).getAddress( _markerLocations.indexOf(markerLocation)+1);
      String address = data.address;
      print('add is $address');
      String status = '';
      if(1.38<=(data.pas)/(data.distance)) {
        status = 'Walk';
      }
      if(1.18<=(data.pas)/(data.distance) && (data.pas)/(data.distance)<1.38) {
        status = 'Jog';
      }
      if(1.03<=(data.pas)/(data.distance) && (data.pas)/(data.distance)<1.18) {
        status = 'Run';
      }
      if(0.85<=(data.pas)/(data.distance) && (data.pas)/(data.distance)<1.03) {
        status = 'Fast Run';
      }
      if(data.vitesse>5 && data.distance>3000){
        status = 'Transport';
      }
      else {
        status = 'Walk';
      }
      _sourcePinData = PinData(
        id: _markerLocations.indexOf(markerLocation)+1,
        locationName: address,
        activity: status,
        time: data.elapsedTime
      );
      markers.add(
        MapMarker(
          id: _markerLocations.indexOf(markerLocation).toString(),
          position: markerLocation,
          icon: BitmapDescriptor.defaultMarker,
          setThePins: () {
            setState(() {
              _currentPinData = _sourcePinData;
              _pinPillPosition = 0;
            });
          },
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
      ..clear()
      ..addAll(updatedMarkers);
    if(mounted){
    setState(() {
      _areMarkersLoading = false;
    });
    }
  }
  Future<void> getPermission() async {
    PermissionStatus permission = await Permission.location.status;

    if (permission == PermissionStatus.denied) {
      await Permission.locationAlways.request();
    }
     var geolocators = geolocator.Geolocator();

    geolocator.GeolocationStatus geolocationStatus =
        await geolocators.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case geolocator.GeolocationStatus.denied:
        showToast('Access denied');
        break;
      case geolocator.GeolocationStatus.disabled:
        showToast('Disabled');
        break;
      case geolocator.GeolocationStatus.restricted:
        showToast('restricted');
        break;
      case geolocator.GeolocationStatus.unknown:
        showToast('Unknown');
        break;
      case geolocator.GeolocationStatus.granted:
        showToast('Accesss Granted');
        _getCurrentLocation();
    }
  }
   void _getCurrentLocation() async {
    geolocator.Position res = await geolocator.Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = 1;
    });
  }

    void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  


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
         
          Container(
            height:640.0,
            width: 450.0,
            child: Stack(
              children: <Widget>[
                     _child==0?
                       Center(
                            child: Text('Loading...'),
                          )
                     :
                     
                     GoogleMap(
                        mapType: MapType.hybrid,
                        mapToolbarEnabled: false,
                        initialCameraPosition:CameraPosition(
                        target: LatLng(position.latitude, position.longitude), zoom: 14.4746),
                        markers: _markers,
                        onMapCreated: (controller) => _onMapCreated(controller),
                        onCameraMove: (position) => _updateMarkers(position.zoom),
                        tiltGesturesEnabled: false,
                        onTap: (LatLng location) {
                          setState(() {
                            _pinPillPosition = -100;
                          });
                        },
                  ),
                     
                     AnimatedPositioned(
          bottom: _pinPillPosition,
          right: 0,
          left: 0,
          duration: Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.5),
                    )
                  ]),
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLocationInfo(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: _Header(isRunning: _isTracking,
                          onTogglePressed: _onTogglePressed,),
                          
                 
                )

              ]
            )
      
           ),
        ],
      ),

    );
  }
   Widget _buildLocationInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Location :${ _currentPinData.locationName}' ), 
            Text('${_currentPinData.activity}'),
            Text('${_currentPinData.time}'),
           
              //style: CustomAppTheme().data.textTheme.subtitle,
          ],
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
          title: isRunning ? 'Stop tracking' : 'Start tracking',
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

 