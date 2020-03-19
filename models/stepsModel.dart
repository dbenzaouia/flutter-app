import 'dart:convert';


Steps stepsFromJson(String str) {
  final jsonData = json.decode(str);
  return Steps.fromMap(jsonData);
}

String stepsToJson(Steps data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class Steps {
  int id;
  int numberSteps;
  String theTime;

  Steps({
    this.id,
    this.theTime,
    this.numberSteps,
  });

  factory Steps.fromMap(Map<String, dynamic> json) => new Steps(
        id: json["id"],
        numberSteps: json["numberSteps"],
        theTime: json["theTime"],
        
      );

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['numberSteps'] = numberSteps;
    map['theTime'] = theTime;
    return map;
    }
}