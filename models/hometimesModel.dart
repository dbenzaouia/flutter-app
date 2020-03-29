import 'dart:convert';


HomeTimes hometimesFromJson(String str) {
  final jsonData = json.decode(str);
  return HomeTimes.fromMap(jsonData);
}

String hometimesToJson(HomeTimes data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class HomeTimes {
  int id;
  String theTime;

  HomeTimes({
    this.id,
    this.theTime,
  });

  factory HomeTimes.fromMap(Map<String, dynamic> json) => new HomeTimes(
        id: json["id"],
        theTime: json["theTime"],
        
      );
  

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['theTime'] = theTime;
    return map;
    }
}