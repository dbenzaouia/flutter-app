import 'dart:async';

import '../models/stepsModel.dart';
import 'database.dart';

class StepsManager{
  
  final DBProvider dbProvider;

  StepsManager(this.dbProvider);
  
  Future<void>addNewSteps(Steps steps) async{
    return dbProvider.addNewSteps(steps); 
  }
  
  /*Future<List>getSteps() async{
    return dbProvider.getSteps();
  }*/

}