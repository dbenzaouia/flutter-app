import 'package:flutter/material.dart';
import 'package:app/widget/list_widget.dart';
import 'package:app/pedometre.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:app/models/stepsModel.dart';
import 'package:app/data/database.dart';



class PedometerWidget {
  Widget pedometerWidget(int nbSteps,List<charts.Series<StepsDay, String>> series, List<StepsDay> steps){
      return new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Icon(Icons.directions_walk),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Real time step counter: $nbSteps'),
               ),
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Number of steps per day",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: charts.BarChart(series, animate: true),
                        ),
                      ],
                    
                  ),
                ),
              ), 
              new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepList(steps),
               ),
              ),   
               ]
                  
        ),
       
        
      );

  }
}
class PedometerWidgetAnnuel {
  Widget pedometerWidget(int nbSteps,List<charts.Series<StepsMonths, String>> series, List<StepsMonths> steps){
      return new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Icon(Icons.directions_walk),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Real time step counter: $nbSteps'),
               ),
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Number of steps per months",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: charts.BarChart(series, animate: true),
                        ),
                      ],
                    
                  ),
                ),
              ), 
              new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepListMonths(steps),
               ),
              ),   
               ]
                  
        ),
       
        
      );

  }
}
class PedometerWidgetMonths {
  Widget pedometerWidget(int nbSteps,List<charts.Series<StepsDays, String>> series, List<StepsDays> steps){
      return new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Icon(Icons.directions_walk),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Real time step counter: $nbSteps'),
               ),
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Number of steps per months",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: charts.BarChart(series, animate: true),
                        ),
                      ],
                    
                  ),
                ),
              ), 
              new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepListDays(steps),
               ),
              ),   
               ]
                  
        ),
       
        
      );

  }
}
class PedometerWidgetWeek {
  Widget pedometerWidget(int nbSteps,List<charts.Series<StepsDays, String>> series, List<StepsDays> steps){
      return new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Icon(Icons.directions_walk),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Real time step counter: $nbSteps'),
               ),
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Number of steps per week",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 600,
                          height: 300,
                          child: charts.BarChart(series, animate: true),
                        ),
                      ],
                    
                  ),
                ),
              ), 
              new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepListWeek(steps),
               ),
              ),   
               ]
                  
        ),
       
        
      );

  }
}