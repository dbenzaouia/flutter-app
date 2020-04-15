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
  int theDay;
  int theMonths;
  int theYear;
  int theHours;
  int theMin;
  String thePart;

  Steps({
    this.id,
    this.theTime,
    this.numberSteps,
     this.theDay,
    this.theMonths,
    this.theYear,
    this.theHours,
    this.theMin,
    this.thePart,
  });

  factory Steps.fromMap(Map<String, dynamic> json) => new Steps(
        id: json["id"],
        numberSteps: json["numberSteps"],
        theTime: json["theTime"],
        theDay: json["theDay"],
        theMonths: json["theMonths"],
        theYear: json["theYear"],
        theHours: json["theHours"],
        theMin: json["theMin"],
        thePart: json["thePart"]
        
      );

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['numberSteps'] = numberSteps;
    map['theTime'] = theTime;
    map['theDay'] = theDay;
    map['theMonths'] = theMonths;
    map['theYear'] = theYear;
    map['theHours'] = theHours;
    map['theMin'] = theMin;
    map['thePart'] = thePart;
    return map;
    }
}