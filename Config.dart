import 'dart:convert';


Config ConfigFromJson(String str) {
  final jsonData = json.decode(str);
  return Config.fromMap(jsonData);
}

String ConfigToJson(Config data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Config {

  int id;
  String wifiname;
  String wifiIP;
  int hometime;
  int sleeptime;
  int pedometre;


Config({this.id,this.wifiname,this.wifiIP,this.hometime,this.sleeptime,this.pedometre,});

factory Config.fromMap(Map<String, dynamic> json) => new Config(
        id: json["id"],
        wifiname: json["wifiname"],
        wifiIP: json["wifiIP"],
        hometime: json["hometime"],
        sleeptime: json["sleeptime"],
        pedometre: json["pedometer"],
        
      );
  

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['wifiname'] = wifiname;
    map['wifiIP'] = wifiIP;
    map['hometime'] = hometime;
    map['sleeptime'] = sleeptime;
    map['pedometre'] = pedometre;



    return map;
    }
}