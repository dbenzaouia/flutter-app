import 'dart:async';

import '../Config.dart';
import 'database.dart';

class ConfigManager{
  
  final DBProvider dbProvider;

  ConfigManager(this.dbProvider);
  
  Future<void>addNewConfig(Config config) async{
    return dbProvider.addNewConfig(config); 
  }

  Future<void> updateConfig(Config config) async {
    return dbProvider.updateConfig(config); 
  }
  /*Future<List>getSteps() async{
    return dbProvider.getSteps();
  }*/

}