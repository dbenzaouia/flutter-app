import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:projet_geo/homeSleep.dart';

import '../homeSleepGraph.dart';

class HSWidgetWeek {
  Widget hsWidgetWeek(){
      List<charts.Series<DataListHS, DateTime>> data;
      return new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[              
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Time spend at home last week",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataListHS, DateTime>>>(
                            future: HSGraphState.hsDataWeek(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.TimeSeriesChart(data, animate: true,
                                dateTimeFactory: const charts.LocalDateTimeFactory(),
                                );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error:\n\n${snapshot.error}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Text('Il n\'y a pas de données');
                            }
                       } )
                        ),
                      ],      
                  ),
                ),
              ), 
            ]       
        ),
      );
  }
}
class HSWidgetMonths {
   Widget hsWidgetMonth(){
      List<charts.Series<DataListHS, DateTime>> data;
      return new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[              
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Time spend at home last month",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataListHS, DateTime>>>(
                            future: HSGraphState.hsDataMonth(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.TimeSeriesChart(data, animate: true,
                                dateTimeFactory: const charts.LocalDateTimeFactory(),
                                );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error:\n\n${snapshot.error}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Text('Il n\'y a pas de données');
                            }
                       } )
                        ),
                      ],      
                  ),
                ),
              ), 
            ]       
        ),
      );
  }
}