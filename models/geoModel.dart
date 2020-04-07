import 'dart:convert';

Geoloc geolocFromJson(String str) {
  final jsonData = json.decode(str);
  return Geoloc.fromMap(jsonData);
}

String geolocToJson(Geoloc data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class Geoloc{
  int id;
  String address;
  String elapsedTime;

  Geoloc({
    this.id,
    this.address,
    this.elapsedTime
  });
  factory Geoloc.fromMap(Map<String, dynamic> json) => new Geoloc(
        id: json["id"],
        address: json["address"],
        elapsedTime: json["elapsedTime"],
      );

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['address'] = address;
    map['elapsedTime'] = elapsedTime;
    return map;
    }
}