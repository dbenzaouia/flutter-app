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
  num lat;
  num long;
  int vitesse;
  int pas;
  int pasParMetre;

  Geoloc({
    this.id,
    this.address,
    this.elapsedTime,
    this.elapsedDuration,
    this.diffDuration,
    this.distance,
    this.coordinates,
    this.lat,
    this.long,
    this.vitesse,
    this.pas,
    this.pasParMetre
  });
  factory Geoloc.fromMap(Map<String, dynamic> json) => new Geoloc(
        id: json["id"],
        address: json["address"],
        elapsedTime: json["elapsedTime"],
        elapsedDuration: json["elapsedDuration"],
        diffDuration: json["diffDuration"],
        distance: json["distance"],
        coordinates: json["coordinates"],
        lat: json["lat"],
        long: json["long"],
        vitesse: json["vitesse"],
        pas: json["pas"],
        pasParMetre: json["pasParMetre"]

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
    map['lat'] = lat;
    map['long'] = long;
    map['vitesse'] = vitesse;
    map['pas'] = pas;
    map['pasParMetre'] = pasParMetre;
    return map;
    }
}