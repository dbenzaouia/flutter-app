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
  int location;
  int bluetooth;


Config({this.id,this.wifiname,this.wifiIP,this.hometime,this.sleeptime,this.pedometre,this.location,this.bluetooth,});

factory Config.fromMap(Map<String, dynamic> json) => new Config(
        id: json["id"],
        wifiname: json["wifiname"],
        wifiIP: json["wifiIP"],
        hometime: json["hometime"],
        sleeptime: json["sleeptime"],
        pedometre: json["pedometre"],
        location: json["location"],
        bluetooth: json["bluetooth"],
        
      );
  

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['wifiname'] = wifiname;
    map['wifiIP'] = wifiIP;
    map['hometime'] = hometime;
    map['sleeptime'] = sleeptime;
    map['pedometre'] = pedometre;
    map['location'] = location;
    map['bluetooth'] = bluetooth;



    return map;
    }
}