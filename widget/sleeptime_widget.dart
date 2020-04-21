import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/sleepTime.dart';
import 'package:flutter_app/sleepGraph.dart';

class SleeptimeWidget {
  Widget sleeptimeWidgetday(){
      List<charts.Series<DataDay, String>> data;
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
                          "Time spend sleeping",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataDay, String>>>(
                            future: SleepGraphState.withDataDay(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.PieChart(data, defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.outside)
                              ]));
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
class SleeptimeWidgetWeek {
  Widget sleeptimeWidgetweek(){
      List<charts.Series<DataListS, DateTime>> data;
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
                          "Time spend sleeping last week",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataListS, DateTime>>>(
                            future: SleepGraphState.withDataWeek(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.TimeSeriesChart(data, animate: true,
                                dateTimeFactory: const charts.LocalDateTimeFactory(),
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
class SleeptimeWidgetMonths {
   Widget sleeptimeWidgetMonth(){
      List<charts.Series<DataListS, DateTime>> data;
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
                          "Time spend sleeping last month",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataListS, DateTime>>>(
                            future: SleepGraphState.withDataMonth(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.TimeSeriesChart(data, animate: true,
                                dateTimeFactory: const charts.LocalDateTimeFactory(),
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

