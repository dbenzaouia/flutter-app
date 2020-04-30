import 'package:flutter/material.dart';
import 'configModel.dart';
import 'data/configManager.dart';
import 'data/database.dart';
import 'ConfigWifi.dart';
import './ConfigBlue.dart';

class Configuration extends StatefulWidget {
  ConfigState createState() => new ConfigState();
}

class ConfigState extends State<Configuration> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  bool _configurationDone;
  bool configNotLoad;
  bool isSwitched = true;
  int hometime;
  int sleeptime;
  int pedometre;
  int location;
  int bluetooth;
  String wifiname;
  String wifiIP;
  String _sentence1;
  String _sentence2;
  String _sentence3;
  String _sentence4;
  String _sentence5;

  @override
  void initState() {
    _configurationDone = false;
    configNotLoad = true;
    hometime = 0;
    sleeptime = 0;
    pedometre = 0;
    location = 0;
    bluetooth = 0;
    _sentence1 = 'Hometime disabled';
    _sentence2 = 'Sleeptime disabled';
    _sentence3 = 'Pedometre disabled';
    _sentence4 = 'Location disabled';
    _sentence5 = 'Bluetooth disabled';
    wifiname = '';
    wifiIP = '';
    super.initState();
  }

  void loadConfig() async {
    var _config = await dataBase.getConfig(1);
    print(_config.hometime);
    setState(() {
      hometime = _config.hometime;
      sleeptime = _config.sleeptime;
      pedometre = _config.pedometre;
      location = _config.location;
      bluetooth = _config.bluetooth;
      wifiname = _config.wifiname;
      wifiIP = _config.wifiIP;
      hometime == 1
          ? _sentence1 = 'Hometime enabled'
          : _sentence1 = 'Hometime disabled';
      sleeptime == 1
          ? _sentence2 = 'Sleeptime enabled'
          : _sentence2 = 'Sleeptime disabled';
      pedometre == 1
          ? _sentence3 = 'Pedometre enabled'
          : _sentence3 = 'Pedometre disabled';
      location == 1
          ? _sentence4 = 'Location enabled'
          : _sentence4 = 'Location disabled';
      bluetooth == 1
          ? _sentence5 = 'Bluetooth enabled'
          : _sentence5 = 'Bluetooth disabled';
      configNotLoad = false;
    });
  }

  int toInt(bool val) {
    if (val == true) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (configNotLoad) {
      loadConfig();
      return Scaffold(
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                heightFactor: 20,
                child: Text(
                  'Chargement configuration',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    } else {
      if (_configurationDone) {
        Config config = Config(
            id: 1,
            wifiname: wifiname,
            wifiIP: wifiIP,
            hometime: hometime,
            sleeptime: sleeptime,
            pedometre: pedometre,
            location: location,
            bluetooth: bluetooth);
        ConfigManager(dbProvider).updateConfig(config);
        setState(() {
          _configurationDone = false;
        });
      }
      // Build a Form widget using the _formKey created above.
      return Form(
        key: _formKey,
        child: Padding(
          padding: new EdgeInsets.all(20),
          child: new Column(
            children: <Widget>[
              // new ConfigWifi(),

              Card(
                child: ListTile(
                  title: Text('HomeTime'),
                  subtitle: Text(
                    'it involves more settings',
                    style: TextStyle(fontSize: 10),
                  ),
                  trailing: Switch(
                    value: hometime == 1,
                    onChanged: (value) {
                      setState(() {
                        hometime = toInt(value);
                        _configurationDone = true;
                      });
                      if (value) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('HomeTime'),
                            content: Text(
                                'In order to activate HomeTime service, please complete Wifi settings'),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfigWifi()),
                                  );
                                },
                                child: Text('Go to Wifi settings'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    activeTrackColor: Colors.indigoAccent[300],
                    activeColor: Colors.indigoAccent,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigWifi()),
                    );
                  },
                ),
              ),

              Card(
                child: ListTile(
                  title: Text('Pedometre'),
                  trailing: Switch(
                    value: pedometre == 1,
                    onChanged: (value) {
                      setState(() {
                        pedometre = toInt(value);
                        _configurationDone = true;
                      });
                    },
                    activeTrackColor: Colors.indigoAccent[300],
                    activeColor: Colors.indigoAccent,
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  title: Text('SleepTime'),
                  trailing: Switch(
                    value: sleeptime == 1,
                    onChanged: (value) {
                      setState(() {
                        sleeptime = toInt(value);
                        _configurationDone = true;
                      });
                    },
                    activeTrackColor: Colors.indigoAccent[300],
                    activeColor: Colors.indigoAccent,
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  title: Text('Location'),
                  trailing: Switch(
                    value: location == 1,
                    onChanged: (value) {
                      setState(() {
                        location = toInt(value);
                        _configurationDone = true;
                      });
                    },
                    activeTrackColor: Colors.indigoAccent[300],
                    activeColor: Colors.indigoAccent,
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  title: Text('Bluetooth'),
                  subtitle: Text(
                    'it involves more settings',
                    style: TextStyle(fontSize: 10),
                  ),
                  trailing: Switch(
                    value: bluetooth == 1,
                    onChanged: (value) {
                      setState(() {
                        bluetooth = toInt(value);
                        _configurationDone = true;
                      });
                      if (value) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Bluetooth'),
                            content: Text(
                                'In order to activate Bluetooth service, please complete bluetooth settings'),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfigBlue()),
                                  );
                                },
                                child: Text('Go to bluetooth settings'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    activeTrackColor: Colors.indigoAccent[300],
                    activeColor: Colors.indigoAccent,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigBlue()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
