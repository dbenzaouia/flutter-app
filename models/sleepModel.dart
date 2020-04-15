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
  int duration;
  int theDay;
  int theMonths;
  int theYear;
  String theHours;
  String theMin;
  int thePart;
   

  SleepTime({this.id,this.duration,this.theDay,
    this.theMonths,
    this.theYear,
    this.theHours,
    this.theMin,
    this.thePart,});
  factory SleepTime.fromMap(Map<String, dynamic> json) => new SleepTime(
        id: json["id"],
        duration: json["duration"],
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
    map['duration'] = duration;
    map['theDay'] = theDay;
    map['theMonths'] = theMonths;
    map['theYear'] = theYear;
    map['theHours'] = theHours;
    map['theMin'] = theMin;
    map['thePart'] = thePart;
    return map;
    }
}