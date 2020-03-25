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
            ],
          );
        },
      ),
    );
    }
  }