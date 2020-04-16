import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sleepModel.dart';
import 'pedometre.dart';
import 'Configuration.dart';
import 'hometime.dart';
import 'sleepTime.dart';
import 'userLocation.dart';
import 'bluetoothmedia.dart';
import 'PedoGraph.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
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
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({Key key});

  @override
    void initState() {
    super.initState();
    startServiceInPlatform();

    }
      void startServiceInPlatform() async {
    if(Platform.isAndroid){
      var methodChannel = MethodChannel("com.retroportalstudio.messages");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text('Flutter app'),
      ),
      body: SingleChildScrollView(
        //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Pedo(),

            RaisedButton(
              child: Text('Open Graph Pedometre'),
              onPressed: () {
                // Navigate to the first screen using a named route.
                Navigator.pushNamed(context, '/first');
              },
            ),
            
            RaisedButton(
              child: Text('Open Hometime'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/second');
              },
            ),
            RaisedButton(
              child: Text('Open Sleeptime'),
              onPressed: () {
                // Navigate to the third screen using a named route.
                Navigator.pushNamed(context, '/third');
              },
            ),
            RaisedButton(
              child: Text('Open Setting'),
              onPressed: () {
                // Navigate to the third screen using a named route.
                Navigator.pushNamed(context, '/fourth');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedometre"),
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

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
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

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep Time"),
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
        title: Text("Configuration"),
      ),
      body: SingleChildScrollView(
        //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Configuration(),
          ],
        ),
      ),
    );
  }
}

