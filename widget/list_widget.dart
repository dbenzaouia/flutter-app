import 'package:flutter/material.dart';


 class BuildStepList {

    Widget buildStepList(steps) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: steps.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(steps[index].id.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('time'),
                    Text(steps[index].theTime),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('nb of steps'),
                    Text(steps[index].numberSteps.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Day'),
                    Text(steps[index].theDay),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Months'),
                    Text(steps[index].theMonths),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Year'),
                    Text(steps[index].theYear),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Hours'),
                    Text(steps[index].theHours),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Min'),
                    Text(steps[index].theMin),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Part'),
                    Text(steps[index].thePart),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    }
  }

   class BuildtimesList{
      Widget buildList(hometimes) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: hometimes.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(hometimes[index].id.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('time'),
                    Text(hometimes[index].theTime),
                  ],
                ),
              ),
               Container(
                child: Column(
                  children: <Widget>[
                    Text('Day'),
                    Text(hometimes[index].theDay),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Months'),
                    Text(hometimes[index].theMonths),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Year'),
                    Text(hometimes[index].theYear),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Hours'),
                    Text(hometimes[index].theHours),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Min'),
                    Text(hometimes[index].theMin),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Part'),
                    Text(hometimes[index].thePart),
                  ],
                ),
              ),
              
            ],
          );
        },
      ),
    );
    }
  }
class BuildBlueList{
      Widget buildList(blue) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: blue.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(blue[index].id.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('name'),
                    Text(blue[index].name),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('time'),
                    Text(blue[index].theTime.toString()),
                  ],
                ),
              ),
               Container(
                child: Column(
                  children: <Widget>[
                    Text('Day'),
                    Text(blue[index].theDay.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Months'),
                    Text(blue[index].theMonths.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Year'),
                    Text(blue[index].theYear.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Hours'),
                    Text(blue[index].theHours.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Min'),
                    Text(blue[index].theMin.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Part'),
                    Text(blue[index].thePart),
                  ],
                ),
              ),
              
            ],
          );
        },
      ),
    );
    }
  }

 class BuildSleepList {

    Widget buildSleepList(sleepTime) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: sleepTime.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(sleepTime[index].id.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('time'),
                    Text(sleepTime[index].duration),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Day'),
                    Text(sleepTime[index].theDay),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Months'),
                    Text(sleepTime[index].theMonths),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Year'),
                    Text(sleepTime[index].theYear),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Hours'),
                    Text(sleepTime[index].theHours),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Min'),
                    Text(sleepTime[index].theMin),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Part'),
                    Text(sleepTime[index].thePart),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    }
 }
class BuildLocationList {
    Widget buildLocationList(locations) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(locations[index].id.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('address'),
                    Text(locations[index].address),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('time'),
                    Text(locations[index].elapsedTime.toString()),
                  ],
                ),
              ),
             

            ],
          );
        },
      ),
    );
    }
  }