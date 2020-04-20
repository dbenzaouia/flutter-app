import 'dart:io';
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
      home: NavigationHomeScreen(),
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
    if (enabled == 0) {
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
              new Pedo(),
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
            new HT(),
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
            new MytestPage(),
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
      body: SingleChildScrollView(
        //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Locations(),
          ],
        ),
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
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new MytestPage(),
          ],
        ),
      ),
    );
  }
}
