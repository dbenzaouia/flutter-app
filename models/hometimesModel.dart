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
  String theDay;
  String theMonths;
  String theYear;
  String theHours;
  String theMin;
  String thePart;





  HomeTimes({
    this.id,
    this.theTime,
    this.theDay,
    this.theMonths,
    this.theYear,
    this.theHours,
    this.theMin,
    this.thePart,

  });

  factory HomeTimes.fromMap(Map<String, dynamic> json) => new HomeTimes(
        id: json["id"],
        theTime: json["theTime"],
        theDay: json["theDay"],
        theMonths: json["theMonths"],
        theYear: json["theYear"],
        theHours: json["theHours"],
        theMin: json["theMin"],
        thePart: json["thePart"],
        
      );
  

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
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