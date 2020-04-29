
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/database.dart';
import '../data/BlueManager.dart';
import '../models/blueModel.dart';
import '../widget/list_widget.dart';
import '../models/ConfigBlueModel.dart';









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


class BMState extends State<BM> {
  List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>();
  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
  bool _isDiscovering;
  int count = 0;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<Blue> blues = [];
  

static ConfigBlueModel make(String nameblue){
  ConfigBlueModel bla=new ConfigBlueModel();
  bla.name=nameblue;
  bla.location=nameblue;
  return bla;
}




  List<ConfigBlueModel> object=[make("bla"),make("nameblue"),make("2")];


   bool resetCounterPressed = false;
  int timeToDisplay = 0;
  var swatch = Stopwatch();

  final dur = Duration(seconds: 1);
  var now = DateTime.now();
  String value="unkown";
  int day;
  int months;
  int year;
  String hours="";
  int min;
  String part;
  int val=0;


  BMState();

  @override


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
  String todayHours() {
    var now = new DateTime.now();
    String formattedTime = (DateFormat('kk').format(now));
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

 void initState() {
    super.initState();
    setupList();
    setupConfig();

  const fiveSec = const Duration(seconds: 1);
    new Timer.periodic(fiveSec, (Timer t) {
      liste();
    });
  


    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
      
        
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
    setupConfig();
    count=0;
    if(devices.length>0 && value=="unkown" ){
      for (var i = 0; i < devices.length; i++) {
        if(object!=null){

        for (var j = 0; j < object.length; j++) {
          if(devices[i].device.isConnected && devices[i].device.name ==object[j].name && timeToDisplay==0){
            count++;
            _save(devices[i].device.name);
            swatch.start();
            starttimer();
            val=1;
            }
          }
        }
      }
    }
    else if(devices.length>0 && value!="unkown" ){
      for (var i = 0; i < devices.length; i++) {
          if(!devices[i].device.isConnected && devices[i].device.name ==value){
            countTheTimeBlue;
            resetStepCounter();
            _save("unkown");
            swatch.stop();
          }
        }
    }
  else if (devices.length==0){
      if(timeToDisplay>0 && value!="unkown"){
         countTheTimeBlue;
        resetStepCounter();
        _save("unkown");
        swatch.stop();
      }
    }
    
  
  }
   _save(name) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    if ((swatch.elapsed.inSeconds%1)==0){
      value = ('$name');
      prefs.setString(key, value);
    }
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
   void setupConfig() async{
    var _object = await dataBase.fetchAllConfigBlue();
    print(_object);
    setState(() {
      object = _object;
    });
  }
  
  Widget build(BuildContext context) {
    
      return new Container(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("Bluetooth service allumé")
       /*new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildBlueList().buildList(blues),
               ),
              ),  
              */
            ],
          ),
        );
  }
}