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
  int _hometime;
  int _sleeptime;
  int _pedometre;
  int _location;
  int _bluetooth;
  String _wifiname;
  String _wifiIP;
  String _sentence1;
  String _sentence2;
  String _sentence3;
  String _sentence4;
  String _sentence5;

  @override
  void initState() {
    _configurationDone = false;
    _hometime = 0;
    _sleeptime = 0;
    _pedometre = 0;
    _location = 0;
    _bluetooth = 0;
    _sentence1 = 'Hometime disabled';
    _sentence2 = 'Sleeptime disabled';
    _sentence3 = 'Pedometre disabled';
    _sentence4 = 'Location disabled';
    _sentence5 = 'Bluetooth disabled';
    _wifiname = '';
    _wifiIP = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (_configurationDone){
      Config config = Config(id: 1,wifiname: _wifiname, wifiIP: _wifiIP, hometime: _hometime, sleeptime: _sleeptime, pedometre: _pedometre, location: _location, bluetooth: _bluetooth);
      ConfigManager(dbProvider).updateConfig(config);
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
                _wifiname = value;
                return null;
              },
              decoration: new InputDecoration(
                  hintText: 'examplebox', labelText: 'Wifi name'),
            ),
              new TextFormField(
              validator: (value) {
                _wifiIP = value;
                return null;
              },
              decoration: new InputDecoration(
                  hintText: '***.***.***.***', labelText: 'Wifi IP'),
            ),
            new Container(
              child: new RaisedButton(
                  color: _hometime==1 ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence1),
                  onPressed: () {
                    setState(() {
                      _hometime==1  ? _hometime = 0: _hometime = 1;
                      _sentence1 == 'Hometime enabled'
                          ? _sentence1 = 'Hometime disabled'
                          : _sentence1 = 'Hometime enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            new Container(
              child: new RaisedButton(
                  color: _sleeptime==1 ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence2),
                  onPressed: () {
                    setState(() {
                      _sleeptime==1 ? _sleeptime = 0 : _sleeptime = 1;
                      _sentence2 == 'Sleeptime enabled'
                          ? _sentence2 = 'Sleeptime disabled'
                          : _sentence2 = 'Sleeptime enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            new Container(
              child: new RaisedButton(
                  color: _pedometre==1 ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence3),
                  onPressed: () {
                    setState(() {
                      _pedometre==1 ? _pedometre = 0 : _pedometre = 1;
                      _sentence3 == 'Pedometre enabled'
                          ? _sentence3 = 'Pedometre disabled'
                          : _sentence3 = 'Pedometre enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            new Container(
              child: new RaisedButton(
                  color: _location==1 ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence4),
                  onPressed: () {
                    setState(() {
                      _location==1 ? _location = 0 : _location = 1;
                      _sentence4 == 'Location enabled'
                          ? _sentence4 = 'Location disabled'
                          : _sentence4 = 'Location enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            new Container(
              child: new RaisedButton(
                  color: _bluetooth==1 ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence5),
                  onPressed: () {
                    setState(() {
                      _bluetooth==1 ? _bluetooth = 0 : _bluetooth = 1;
                      _sentence5 == 'Bluetooth enabled'
                          ? _sentence5 = 'Bluetooth disabled'
                          : _sentence5 = 'Bluetooth enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            new Container(
              child: new RaisedButton(
                  child: new Text('Appliquer'),
                  onPressed: () {
                     setState(() {
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
