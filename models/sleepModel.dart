import 'dart:convert';


SleepTime sleepTimeFromJson(String str) {
  final jsonData = json.decode(str);
  return SleepTime.fromMap(jsonData);
}

String sleepTimeToJson(SleepTime data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class SleepTime{
  int id;
  String duration;

  SleepTime({this.id,this.duration});
  factory SleepTime.fromMap(Map<String, dynamic> json) => new SleepTime(
        id: json["id"],
        duration: json["duration"],
        
      );

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['duration'] = duration;
    return map;
    }
}