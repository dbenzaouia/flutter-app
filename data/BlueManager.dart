import 'dart:async';

import '../models/blueModel.dart';
import 'database.dart';

class BlueManager{
  
  final DBProvider dbProvider;

  BlueManager(this.dbProvider);
  
  Future<void>addNewBlue(Blue blue) async{
   // print(geoloc.address);
    return dbProvider.addNewBlue(blue); 
  }
  
  /*Future<List>getSteps() async{
    return dbProvider.getSteps();
  }*/

}