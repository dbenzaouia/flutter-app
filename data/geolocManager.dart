import 'dart:async';

import '../models/geoModel.dart';
import 'database.dart';

class GeolocManager{
  
  final DBProvider dbProvider;

  GeolocManager(this.dbProvider);
  
  Future<void>addNewGeoloc(Geoloc geoloc) async{
   // print(geoloc.address);
    return dbProvider.addNewGeoloc(geoloc); 
  }
  Future<Geoloc> getLastFetch() async{
    return dbProvider.getLastFetch();
  }
  Future<List> getLocalisations() async{
    return dbProvider.getLocalisations();
  }
  Future<int> updateGeoloc(Geoloc newCar) async{
     return dbProvider.updateGeoloc(newCar);
  }
  Future<List<num>> getLatitude() async {
     return dbProvider.getLatitude();
  }
  Future<List<num>> getLongitude() async {
     return dbProvider.getLongitude();
  }
  Future<Geoloc> getAddress(int id) async {
    return dbProvider.getAddress(id);
  }
  /*Future<List>getSteps() async{
    return dbProvider.getSteps();
  }*/

}