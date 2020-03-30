import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:app/widget/sleepTracker.dart';
import 'pedometre.dart';
import 'sleepTime.dart';
import 'hometime.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Pedometer Demo Home Page'),
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
  String values;
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      resizeToAvoidBottomPadding: false ,
      appBar: AppBar(
        title: const Text('Flutter app'),
      ),
      body: SingleChildScrollView(
      //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
       child : new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[ 
              //new Pedo(),
             //new MytestPage(),
             new HT(),
             new Pedo(),
             new MytestPage(),
          ],
          
      ),
      ),
    );
  }
 

}