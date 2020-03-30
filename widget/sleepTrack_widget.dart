
import 'package:flutter/material.dart';
import 'package:app/models/sleepModel.dart';
import 'package:app/widget/list_widget.dart';



class WidgetLight {
  List<String> accel;
  List<String> gyros;
  String luxie;
  int count;
  String timeToDisplay;
  List<SleepTime> sleep;
  WidgetLight(this.accel,this.gyros,this.luxie,this.count,this.timeToDisplay, this.sleep);

  Widget buildmywid(){
  return Container(
     
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
       child : new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[ 
          new Padding(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Accelerometer: $accel'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          new Padding(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Gyroscope: $gyros'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          new Padding(
          child: new Text('Running on: $luxie\n'),
           padding: const EdgeInsets.all(16.0),
          ),
           new Padding(
          child: new Text('je dors depuis : $count and time is : $timeToDisplay\n'),
           padding: const EdgeInsets.all(16.0),
          ),
          /*new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildSleepList().buildSleepList(sleep),
               ),
              ), */
          
          ],
          
      ),
      
    );

  }

}