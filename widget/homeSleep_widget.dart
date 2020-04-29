import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../service/homeSleep.dart';

import '../Graph/homeSleepGraph.dart';

class HSWidgetDay {
  Widget hsWidgetDay(){
      List<charts.Series<DataDayHS, String>> data;
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
                          "Time spend at home and sleeping today",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataDayHS, String>>>(
                            future: HSGraphState.hsDataDay(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.PieChart(data, animate: true,
                                behaviors: [new charts.SeriesLegend(position: charts.BehaviorPosition.bottom)],
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
class HSWidgetWeek {
  Widget hsWidgetWeek(){
      List<charts.Series<DataListHS, String>> data;
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
                          "Time spend at home and sleeping last week",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataListHS, String>>>(
                            future: HSGraphState.hsDataWeek(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.LineChart(data,
                                defaultRenderer:
                                new charts.LineRendererConfig(includeArea: true, stacked: true),
                                animate: true);
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
      List<charts.Series<DataListHS, String>> data;
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
                          "Time spend at home and sleeping last month",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataListHS, String>>>(
                            future: HSGraphState.hsDataMonth(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.LineChart(data,
                                defaultRenderer:
                                new charts.LineRendererConfig(includeArea: true, stacked: true),
                                animate: true);
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