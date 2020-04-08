import 'dart:convert';

Blue blueFromJson(String str) {
  final jsonData = json.decode(str);
  return Blue.fromMap(jsonData);
}

String blueToJson(Blue data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class Blue{
  int id;
  String name;
  int theTime;
  int theDay;
  int theMonths;
  int theYear;
  int theHours;
  int theMin;
  String thePart;

  Blue({
    this.id,
  this.name,
  this.theTime,
  this.theDay,
  this.theMonths,
  this.theYear,
  this.theHours,
  this.theMin,
  this.thePart,
  });
  factory Blue.fromMap(Map<String, dynamic> json) => new Blue(
        id: json["id"],
        name: json["name"],
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
    map['name'] = name;
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