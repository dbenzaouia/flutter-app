import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/hometime.dart';
import 'package:flutter_app/homeGraph.dart';

class HometimeWidget {
  Widget hometimeWidgetday(){
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
                          "Time spend at home today",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: FutureBuilder<List<charts.Series<DataDay, String>>>(
                            future: HomeGraphState.withDataDay(), // a previously-obtained Future<String> or null
                            builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              data = snapshot.data;
                              return charts.PieChart(data,defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
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
class HometimeWidgetWeek {
  Widget hometimeWidgetweek(){
      List<charts.Series<DataList, DateTime>> data;
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
                          child: FutureBuilder<List<charts.Series<DataList, DateTime>>>(
                            future: HomeGraphState.withDataWeek(), // a previously-obtained Future<String> or null
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
class HometimeWidgetMonths {
   Widget hometimeWidgetMonth(){
      List<charts.Series<DataList, DateTime>> data;
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
                          child: FutureBuilder<List<charts.Series<DataList, DateTime>>>(
                            future: HomeGraphState.withDataMonth(), // a previously-obtained Future<String> or null
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