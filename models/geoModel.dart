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
  int elapsedDuration;
  int diffDuration;
  int distance;
  String coordinates;
  int vitesse;
  int pas;

  Geoloc({
    this.id,
    this.address,
    this.elapsedTime,
    this.elapsedDuration,
    this.diffDuration,
    this.distance,
    this.coordinates,
    this.vitesse,
    this.pas
  });
  factory Geoloc.fromMap(Map<String, dynamic> json) => new Geoloc(
        id: json["id"],
        address: json["address"],
        elapsedTime: json["elapsedTime"],
        elapsedDuration: json["elapsedDuration"],
        diffDuration: json["diffDuration"],
        distance: json["distance"],
        coordinates: json["coordinates"],
        vitesse: json["vitesse"],
        pas: json["pas"]

      );

  Map<String, dynamic> toMap()  {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['address'] = address;
    map['elapsedTime'] = elapsedTime;
    map['elapsedDuration'] = elapsedDuration;
    map['diffDuration'] = diffDuration;
    map['distance'] = distance;
    map['coordinates'] = coordinates;
    map['vitesse'] = vitesse;
    map['pas'] = pas;
    return map;
    }
}