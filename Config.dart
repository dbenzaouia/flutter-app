class Config {

  bool hometime;
  bool sleeptime;
  bool pedometre;
  String wifiname;
  String wifiIP;

void configuration(bool hometime, bool sleeptime, bool pedometre, String wifiname, String wifiIP){
  this.wifiname=wifiname;
  this.hometime=hometime;
  this.sleeptime=sleeptime;
  this.pedometre=pedometre;
  this.wifiIP=wifiIP;
}

Config({this.hometime,this.sleeptime,this.pedometre,this.wifiname,this.wifiIP,});
}