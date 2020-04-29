import 'package:flutter/material.dart';

class HT extends StatefulWidget {
  State createState() => new HTState();
}

class HTState extends State<HT> {
  @override
  Widget build(BuildContext context) {
     return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Hometime et Sleeptime activé',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), 
            ],        
        ),        
      ); 
    }
}


class DataDayHS {
  final int time;
  final String location;
  DataDayHS(this.location, this.time);
}

class DataListHS {
  final int time;
  final String day;
  DataListHS(this.day, this.time);
}