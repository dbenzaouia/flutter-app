import 'dart:async';
import '../models/ConfigBlueModel.dart';

import 'database.dart';

class ConfigBlueManager{
  
  final DBProvider dbProvider;

  ConfigBlueManager(this.dbProvider);
  
  Future<void>addNewConfigBlue(ConfigBlueModel configblue) async{
    return dbProvider.addNewConfigBlue(configblue); 
  }

  Future<void> updateConfigBlue(ConfigBlueModel configBlue, int id) async {
    return dbProvider.updateConfigBlue(configBlue, id); 
  }


}