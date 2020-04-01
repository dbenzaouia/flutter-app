import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'pedometre.dart';
import 'Configuration.dart';
import 'hometime.dart';
import 'sleepTime.dart';

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
            RaisedButton(
              child: Text('Open Pedometre'),
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
            new Pedo(),
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
        title: Text("Hometime"),
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