import 'dart:convert';


ConfigBlueModel ConfigBlueModelFromJson(String str) {
  final jsonData = json.decode(str);
  return ConfigBlueModel.fromMap(jsonData);
}

String ConfigBlueModelToJson(ConfigBlueModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ConfigBlueModel {

  int id;
  String name;
  String location;



ConfigBlueModel({this.id,this.name,this.location,});

factory ConfigBlueModel.fromMap(Map<String, dynamic> json) => new ConfigBlueModel(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        
      );
  

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['location'] = location;

    return map;
    }
}