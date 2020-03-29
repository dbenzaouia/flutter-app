import 'dart:async';

import '../models/hometimesModel.dart';
import '../data/database.dart';

class HometimesManager{
  
  final DBProvider dbProvider;

  HometimesManager(this.dbProvider);
  
  Future<void>addNewHometimes(HomeTimes hometimes) async{
    return dbProvider.addNewHomeTimes(hometimes); 
  }
  
  /*Future<List>getSteps() async{
    return dbProvider.getSteps();
  }*/

}