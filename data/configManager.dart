import 'dart:async';

import 'package:app/Config.dart';
import 'package:app/data/database.dart';

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