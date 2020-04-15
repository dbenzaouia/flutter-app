
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/data/database.dart';
import 'package:app/data/BlueManager.dart';
import 'package:app/models/blueModel.dart';
import 'package:app/widget/list_widget.dart';









class BM extends StatefulWidget {

  final bool checkAvailability;

  const BM({this.checkAvailability = true});
  BMState createState() => new BMState();
  
 
}
  enum _DeviceAvailability {
  no,
  maybe,
  yes,
}
class _DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}
class BlueObjet{
  String name;
  String fonction;

 
}

class BMState extends State<BM> {
  List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>();
  //List<BluetoothDeviceListEntry> list;

  // Availability
  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
  bool _isDiscovering;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  int count = 0;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<Blue> blues = [];
  static BlueObjet bal=make("X8","media");
  static BlueObjet ball=make("DESKTOP-0C0N5KJ","ordi");

  List<BlueObjet> object=[bal,ball];


   bool resetCounterPressed = false;
  int timeToDisplay = 0;
  var swatch = Stopwatch();

  final dur = Duration(seconds: 1);
  var now = DateTime.now();
  String media_name="DESKTOP-0C0N5KJ";
  String value="unkown";
  int day;
  int months;
  int year;
  int hours;
  int min;
  String part;
  int val=0;


  BMState();

  @override
   static BlueObjet make(String name,String fonction){
    BlueObjet blue=new BlueObjet();
    blue.name=name;
    blue.fonction=fonction;
    return blue;
  }

  int todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;
  }
  int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;

  }
  int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;

  }
  int todayHours() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('kk').format(now));
    print(formattedTime);
    return formattedTime;
  }
  int todayMin() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('mm').format(now));
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
      timeToDisplay =  (swatch.elapsed.inSeconds).toInt();
    });
  }
 
 
  
  void resetStepCounter() {
    setState(() {
      resetCounterPressed = true;
      swatch.reset();
      timeToDisplay = 0;

    });
  }
  
   


 int get countTheTimeBlue { 
     day=todayDay();
     months=todayMonths();
     year=todayYear();
     hours=todayHours();
     min=todayMin();
     part=today();
   var blue = new Blue(
        id: null,
        name: value,
        theTime: timeToDisplay,
        theDay : day,
        theMonths : months,
        theYear : year,
        theHours : hours,
        theMin : min,
        thePart : part,
      );
      if(blue.theTime != 0){
              BlueManager(dbProvider).addNewBlue(blue); 
      }
    resetStepCounter();

    return blue.theTime;
 
}
/*
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
  */
 void initState() {
    super.initState();
    setupList();

  //First subscription
  const fiveSec = const Duration(seconds: 1);
    new Timer.periodic(fiveSec, (Timer t) {
      liste();
    });
  //Second subscription
  


    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      
        
      FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });

            

        
      });
    });

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }
    // Setup a list of the bonded devices
    
    //}
     FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
          

        // Discoverable mode is disabled when Bluetooth gets disabled
      });
    });
  }
     
void liste() async{
  await FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
            

      });
    });
    chrono();

}
  
  void chrono(){
    count=0;
    print("longueur");
    print(devices.length);
    if(devices.length>0 && value=="unkown" ){
      for (var i = 0; i < devices.length; i++) {
        print(devices[i].device.isConnected);
        print("i");
        print(i);
        for (var j = 0; j < object.length; j++) {
          print(timeToDisplay);
          if(devices[i].device.isConnected && devices[i].device.name ==object[j].name && timeToDisplay==0){
            print("je suis connecte aec ");
            print(devices[i].device.name);
            count++;
            print("je suis la je lance le");
            print(devices[i].device.name);
            _save(devices[i].device.name);
            swatch.start();
            starttimer();
            //keeprunning();
            val=1;
            }
          }
        }
      
      print("fin for");
    }
    else if(devices.length>0 && value!="unkown" ){
      print("je rentre else if");
      for (var i = 0; i < devices.length; i++) {
        print(devices[i].device.isConnected);
        print("i");
        print(i);
        print(value);
        print(devices[i].device.name);
        print(!devices[i].device.isConnected);
          if(!devices[i].device.isConnected && devices[i].device.name ==value){
            print("value iscon");
            print(!devices[i].device.isConnected && devices[i].device.name ==value);
            countTheTimeBlue;
            print(timeToDisplay);
            print(value);
            resetStepCounter();
            print(devices[i].device.name);
            _save("unkown");
            swatch.stop();
            
            
          }
        }
    }
  else if (devices.length==0){
      print("aucune connections et pas d app dispo");
      if(timeToDisplay>0 && value!="unkown"){
         countTheTimeBlue;
        print(timeToDisplay);
      print(value);
      resetStepCounter();
      _save("unkown");
      swatch.stop();



      }
      
      print(timeToDisplay);
    }
  
  }
   _save(name) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    if ((swatch.elapsed.inSeconds%1)==0){
      value = ('$name');
      prefs.setString(key, value);
    }
    
    print('saved $value');
  }
  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }
void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;

          }
        }
      });
    });

    _discoveryStreamSubscription.onDone(() {
      setState(() {
        
        _isDiscovering = false;
      });
    });
  }
   void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }
  void setupList() async{
    var _blues = await dataBase.fetchAllBlues();
    print(_blues);
    setState(() {
      blues = _blues;
    });
  }
  Widget build(BuildContext context) {
    
      return new Container(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
       new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildBlueList().buildList(blues),
               ),
              ),  
         //new Container(
           //child: ListView(children: list),
        // ),
        
   
      
            ],
      ),
        );
  }
}