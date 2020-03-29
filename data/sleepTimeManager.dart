import 'dart:async';

import 'package:flutter_app/models/sleepModel.dart';
import 'database.dart';

class SleepTimeManager{
  
  final DBProvider dbProvider;

  SleepTimeManager(this.dbProvider);
  
  Future<void>addNewSleepTime(SleepTime sleepTime) async{
    return dbProvider.addNewSleepTime(sleepTime); 
  }
  
  /*Future<List>getSteps() async{
    return dbProvider.getSteps();
  }*/

}