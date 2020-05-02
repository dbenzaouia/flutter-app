import 'package:flutter/material.dart';
import 'configModel.dart';
import 'data/configManager.dart';
import 'data/database.dart';

class ConfigWifi extends StatefulWidget {
  ConfigWifiState createState() => new ConfigWifiState();
}

class ConfigWifiState extends State<ConfigWifi> {
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

  @override
  Widget build(BuildContext context) {
    if (configNotLoad) {
      loadConfig();
      return Scaffold(
        appBar: AppBar(
          title: Text("Wifi setting"),
        ),
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
      return Scaffold(
        appBar: AppBar(
          title: Text("Wifi setting"),
        ),
        body: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: new EdgeInsets.all(20),
                child: new Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Please enter the name of your network'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            wifiname = value;
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: 'examplebox',
                              labelText: 'Wifi name'),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Please enter your network IP'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6.0,
                      ),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            wifiIP = value;
                            return null;
                          },
                          decoration: new InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: '***.***.***.***',
                              labelText: 'Wifi IP'),
                        ),
                      ),
                    ),
                    Container(
                      child: Builder(
                        builder: (context) => RaisedButton(
                            child: new Text('Apply'),
                            color: Colors.indigoAccent[200],
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(Icons.check),
                                      SizedBox(width: 20,),
                                      Text('Wifi setting has been updated '),
                                    ],
                                  ),
                                  duration: Duration(seconds: 3),
                                ));
                              }

                              setState(() {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                if (_formKey.currentState.validate()) {
                                  _configurationDone = true;
                                }
                              });
                            }),
                      ),
                      margin: new EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
