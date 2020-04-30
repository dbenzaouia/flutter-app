import 'package:flutter/material.dart';
import '../widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/ObjectDisplay.dart';
import '../models/ConfigBlueModel.dart';




class BlueWidgetDay {
  Widget BlueWidget(List<charts.Series<BlueDay, DateTime>> series, List<BlueDay> blue, List<BlueDay> blue2, List<BlueDay> blue3,List<ConfigBlueModel> object){
           return  new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
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
                          "Daily:Connected Time(min) per hour",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                         
                        new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
      new SizedBox(
          height: 350.0,
          child: new charts.TimeSeriesChart(
            series,
            animate: true,
            selectionModels: [
              new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,

              )
              
            ],
            behaviors: [
            new charts.SeriesLegend(
                position: charts.BehaviorPosition.bottom,horizontalFirst: false, desiredMaxRows: object.length)
          ],
            
            
          )
          ),
          
    ]
          )
     ),
                        
                      ],
                    
                  ),
                ),
              ), 
              /*new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepList(steps),
               ),
              ), */  
               ]
                  
        ),
       
        
      );

  }
}
class BlueWidgetYear {
  Widget BlueWidget(List<charts.Series<BlueYear, String>> series,  List<BlueYear> blue, List<BlueYear> blue2, List<BlueYear> blue3,List<ConfigBlueModel> object){
     return  new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
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
                          "Yearly:Connected Time(hour) per year",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                         
                        new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
       new SizedBox(
          height: 350.0,
          child: charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      // Add the series legend behavior to the chart to turn on series legends.
      // By default the legend will display above the chart.
      behaviors: [new charts.SeriesLegend(position: charts.BehaviorPosition.bottom,horizontalFirst: false, desiredMaxRows: object.length)],
      )
          )
          
    ]
          )
     ),
                        
                      ],
                    
                  ),
                ),
              ), 
              /*new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepList(steps),
               ),
              ), */  
               ]
                  
        ),
       
        
      );

  }
}
class BlueWidgetMonths {
  Widget BlueWidget(List<charts.Series<BlueMonths, String>> series,  List<BlueMonths> blue, List<BlueMonths> blue2, List<BlueMonths> blue3,List<ConfigBlueModel> object){
return  new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
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
                          "Monthly:Connected Time(hour) per month",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                         
                        new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
       new SizedBox(
          height: 350.0,
          child: charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      // Add the series legend behavior to the chart to turn on series legends.
      // By default the legend will display above the chart.
      behaviors: [new charts.SeriesLegend(position: charts.BehaviorPosition.bottom,horizontalFirst: false, desiredMaxRows: object.length)],
      )
          )
          
    ]
          )
     ),
                        
                      ],
                    
                  ),
                ),
              ), 
              /*new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepList(steps),
               ),
              ), */  
               ]
                  
        ),
       
        
      );

  }
}
class BlueWidgetWeek {
  Widget BlueWidget(List<charts.Series<BlueWeek, String>> series,  List<BlueWeek> blue, List<BlueWeek> blue2, List<BlueWeek> blue3,List<ConfigBlueModel> object){
return  new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
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
                          "Weekly:Connected Time(hour) per week",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                         
                        new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[
       new SizedBox(
          height: 350.0,
          child: charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      // Add the series legend behavior to the chart to turn on series legends.
      // By default the legend will display above the chart.
      behaviors: [new charts.SeriesLegend(position: charts.BehaviorPosition.bottom,horizontalFirst: false, desiredMaxRows: object.length)],
      )
          )
          
    ]
          )
     ),
                        
                      ],
                    
                  ),
                ),
              ), 
              /*new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepList(steps),
               ),
              ), */  
               ]
                  
        ),
       
        
      );

  }
}