import 'dart:io';
import 'package:design/homeSleepGraph.dart';

import './design/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './design/navigation_home_screen.dart';
import './design/second_app_theme.dart';
import 'pedometre.dart';
import 'sleepTime.dart';
import 'homeTime.dart';
import 'userLocation.dart';
import 'configModel.dart';
import 'data/configManager.dart';
import 'data/database.dart';
import 'PedoGraph.dart';
import 'homeGraph.dart';
import 'bluetoothmedia.dart';
import 'BMGraph.dart';

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

    Config configIni = Config(
      wifiname: '',
      wifiIP: '',
      hometime: 0,
      sleeptime: 0,
      pedometre: 0,
    );
    DBProvider dbProvider = DBProvider.db;
    ConfigManager(dbProvider).addNewConfig(configIni);

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
        '/first': (context) => First(),
        // When navigating to the "/third" route, build the ThirdScreen widget.
        '/second': (context) => Second(),
        '/third': (context) => Third(),
        '/fourth': (context) => Fourth(),
        '/fifth': (context) => Fifth(),
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
    if (enabled == 1) {
      isEnabled();
      return new Container(
          child: Column(
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
          ]));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Podometre"),
        ),
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new PedoGraph(),
            ],
          ),
        ),
      );
    }
  }
}

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeTime"),
      ),
      body: SingleChildScrollView(
        //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new HomeGraph(),
          ],
        ),
      ),
    );
  }
}

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SleepTime"),
      ),
      body: SingleChildScrollView(
        //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new HSGraph(),
          ],
        ),
      ),
    );
  }
}

class Fourth extends StatefulWidget {
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body:
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Locations(),
        ],
      ),
    );
  }
}

class Fifth extends StatefulWidget {
  @override
  _FifthState createState() => _FifthState();
}

class _FifthState extends State<Fifth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth"),
      ),
      body: SingleChildScrollView(
        //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          //  new BMG(),
          ],
        ),
      ),
    );
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
            /* SizedBox(
              height: 0,
              width: MediaQuery.of(context).size.width,
              child: new BM(),
            ), */
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
