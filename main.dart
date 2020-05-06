import 'dart:io';
import './Graph/sleepGraph.dart';

import 'Graph/homeSleepGraph.dart';

import './design/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './design/navigation_home_screen.dart';
import './design/second_app_theme.dart';
import 'service/pedometre.dart';
import 'service/sleepTime.dart';
import 'service/hometime.dart';
import 'userLocationMap.dart';
import 'configModel.dart';
import 'data/configManager.dart';
import 'data/database.dart';
import 'Graph/PedoGraph.dart';
import 'Graph/homeGraph.dart';
import 'service/bluetoothmedia.dart';
import 'Graph/BMGraph.dart';
import 'models/ConfigBlueModel.dart';
import 'data/configBlueManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    //Initialisation config

    Config configIni = Config(
      wifiname: '',
      wifiIP: '',
      hometime: 0,
      sleeptime: 0,
      pedometre: 0,
      location: 0,
      bluetooth: 0,
    );
    DBProvider dbProvider = DBProvider.db;
    ConfigManager(dbProvider).addNewConfig(configIni);

    //Initialisation config Bluetooth
    ConfigBlueModel configBlue1 =
        ConfigBlueModel(id: 1, name: '', location: '');
    ConfigBlueModel configBlue2 =
        ConfigBlueModel(id: 2, name: '', location: '');
    ConfigBlueModel configBlue3 =
        ConfigBlueModel(id: 3, name: '', location: '');

    ConfigBlueManager(dbProvider).addNewConfigBlue(configBlue1);
    ConfigBlueManager(dbProvider).addNewConfigBlue(configBlue2);
    ConfigBlueManager(dbProvider).addNewConfigBlue(configBlue3);

    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: MainWidget(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        //'/': (context) => MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/fifth': (context) => Fifth(),

        '/first': (context) => First(),
        // When navigating to the "/third" route, build the ThirdScreen widget.
        '/second': (context) => Second(),
        '/third': (context) => Third(),
        '/fourth': (context) => Fourth(),
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  int enabled;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  void initState() {
    //initPlatformState();
    enabled = 0;
    super.initState();
  }

  void isEnabled() async {
    var _config = await dataBase.getConfig(1);
    print(_config.pedometre);
    setState(() {
      enabled = _config.pedometre;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (enabled == 0) {
      isEnabled();
      return Scaffold(
        appBar: AppBar(
          title: Text("Pedometer"),
        ),
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                heightFactor: 20,
                child: Text(
                  'Pedometer disabled',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return PedoGraph();
    }
  }
}

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  int enabled;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  void initState() {
    //initPlatformState();
    enabled = 0;
    super.initState();
  }

  void isEnabled() async {
    var _config = await dataBase.getConfig(1);
    print(_config.hometime);
    setState(() {
      enabled = _config.hometime;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (enabled == 0) {
      isEnabled();
      return Scaffold(
        appBar: AppBar(
          title: Text("HomeTime"),
        ),
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                heightFactor: 20,
                child: Text(
                  'HomeTime disabled',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return HomeGraph();
    }
  }
}

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  int enabled;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  void initState() {
    //initPlatformState();
    enabled = 0;
    super.initState();
  }

  void isEnabled() async {
    var _config = await dataBase.getConfig(1);
    print(_config.sleeptime);
    setState(() {
      enabled = _config.sleeptime;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (enabled == 0) {
      isEnabled();
      return Scaffold(
        appBar: AppBar(
          title: Text("SleepTime"),
        ),
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                heightFactor: 20,
                child: Text(
                  'SleepTime disabled',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SleepGraph();
    }
  }
}

class Fourth extends StatefulWidget {
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  int enabled;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  void initState() {
    //initPlatformState();
    enabled = 0;
    super.initState();
  }

  void isEnabled() async {
    var _config = await dataBase.getConfig(1);
    print(_config.location);
    setState(() {
      enabled = _config.location;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (enabled == 0) {
      isEnabled();
      return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                heightFactor: 20,
                child: Text(
                  'Location disabled',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return new LocationMap();
         
    }
  }
}

class Fifth extends StatefulWidget {
  @override
  _FifthState createState() => _FifthState();
}

class _FifthState extends State<Fifth> {
  int enabled;
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  void initState() {
    //initPlatformState();
    enabled = 0;
    super.initState();
  }

  void isEnabled() async {
    var _config = await dataBase.getConfig(1);
    print(_config.bluetooth);
    setState(() {
      enabled = _config.bluetooth;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (enabled == 0) {
      isEnabled();
      return Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth"),
        ),
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                heightFactor: 20,
                child: Text(
                  'Bluetooth disabled',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return BMG();
    }
  }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width + 250,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 0,
              width: MediaQuery.of(context).size.width,
              child: new Pedo(),
            ),
            SizedBox(
              height: 0,
              width: MediaQuery.of(context).size.width,
              child: new HT(),
            ),
            SizedBox(
              height: 0,
              width: MediaQuery.of(context).size.width,
              child: new MytestPage(),
            ),
             SizedBox(
              height: 0,
              width: MediaQuery.of(context).size.width,
              child: new BM(),
            ), 
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width + 250,
              child: NavigationHomeScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
