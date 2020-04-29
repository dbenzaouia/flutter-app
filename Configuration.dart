import 'package:flutter/material.dart';
import 'configModel.dart';
import 'data/configManager.dart';
import 'data/database.dart';

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
      hometime == 1 ? _sentence1 = 'Hometime enabled' : _sentence1 = 'Hometime disabled';
      sleeptime == 1 ? _sentence2 = 'Sleeptime enabled' : _sentence2 = 'Sleeptime disabled';
      pedometre == 1 ? _sentence3 = 'Pedometre enabled' : _sentence3 = 'Pedometre disabled';
      location == 1 ? _sentence4 = 'Location enabled' : _sentence4 = 'Location disabled';
      bluetooth == 1 ? _sentence5 = 'Bluetooth enabled' : _sentence5 = 'Bluetooth disabled';
      configNotLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (configNotLoad) {
      loadConfig();
      return 
      Scaffold(
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
            ],
          ),
        ),
      );
    } 
    else {
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
                new TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    wifiname = value;
                    return null;
                  },
                  decoration: new InputDecoration(
                      hintText: 'examplebox', labelText: 'Wifi name'),
                ),
                new TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    wifiIP = value;
                    return null;
                  },
                  decoration: new InputDecoration(
                      hintText: '***.***.***.***', labelText: 'Wifi IP'),
                ),
                new Container(
                  child: new RaisedButton(
                      child: new Text('Appliquer'),
                      onPressed: () {
                        setState(() {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            _configurationDone = true;
                          }
                        });
                      }),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                new Container(
                  child: new RaisedButton(
                      color: hometime == 1 ? Colors.green[200] : Colors.white,
                      child: new Text(_sentence1),
                      onPressed: () {
                        setState(() {
                          hometime == 1 ? hometime = 0 : hometime = 1;
                          _sentence1 == 'Hometime enabled'
                              ? _sentence1 = 'Hometime disabled'
                              : _sentence1 = 'Hometime enabled';
                          _configurationDone = true;
                        });
                      }),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                new Container(
                  child: new RaisedButton(
                      color: sleeptime == 1 ? Colors.green[200] : Colors.white,
                      child: new Text(_sentence2),
                      onPressed: () {
                        setState(() {
                          sleeptime == 1 ? sleeptime = 0 : sleeptime = 1;
                          _sentence2 == 'Sleeptime enabled'
                              ? _sentence2 = 'Sleeptime disabled'
                              : _sentence2 = 'Sleeptime enabled';
                          _configurationDone = true;
                        });
                      }),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                new Container(
                  child: new RaisedButton(
                      color: pedometre == 1 ? Colors.green[200] : Colors.white,
                      child: new Text(_sentence3),
                      onPressed: () {
                        setState(() {
                          pedometre == 1 ? pedometre = 0 : pedometre = 1;
                          _sentence3 == 'Pedometre enabled'
                              ? _sentence3 = 'Pedometre disabled'
                              : _sentence3 = 'Pedometre enabled';
                          _configurationDone = true;
                        });
                      }),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                new Container(
                  child: new RaisedButton(
                      color: location == 1 ? Colors.green[200] : Colors.white,
                      child: new Text(_sentence4),
                      onPressed: () {
                        setState(() {
                          location == 1 ? location = 0 : location = 1;
                          _sentence4 == 'Location enabled'
                              ? _sentence4 = 'Location disabled'
                              : _sentence4 = 'Location enabled';
                          _configurationDone = true;
                        });
                      }),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                new Container(
                  child: new RaisedButton(
                      color: bluetooth == 1 ? Colors.green[200] : Colors.white,
                      child: new Text(_sentence5),
                      onPressed: () {
                        setState(() {
                          bluetooth == 1 ? bluetooth = 0 : bluetooth = 1;
                          _sentence5 == 'Bluetooth enabled'
                              ? _sentence5 = 'Bluetooth disabled'
                              : _sentence5 = 'Bluetooth enabled';
                          _configurationDone = true;
                        });
                      }),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
              ],
            ),
          ),
        );
      }
    }
}
