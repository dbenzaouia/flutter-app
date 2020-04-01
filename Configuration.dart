import 'package:flutter/material.dart';
import 'Config.dart';

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

  bool _configurationDone;
  bool _hometime;
  bool _sleeptime;
  bool _pedometre;
  String _wifiname;
  String _wifiIP;
  String _sentence1;
  String _sentence2;
  String _sentence3;

  @override
  void initState() {
    _configurationDone = false;
    _hometime = false;
    _sleeptime = false;
    _pedometre = false;
    _sentence1 = 'Hometime disabled';
    _sentence2 = 'Sleeptime disabled';
    _sentence3 = 'Pedometre disabled';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_configurationDone){
    Config config = Config(hometime: _hometime, sleeptime: _sleeptime, pedometre: _pedometre, wifiname: _wifiname, wifiIP: _wifiIP);
    return new Container(
              child: new Text(config.wifiname)
            );
            }
            else{
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
                _wifiname = value;
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
                _wifiIP = value;
                return null;
              },
              decoration: new InputDecoration(
                  hintText: '***.***.***.***', labelText: 'Wifi IP'),
            ),
            new Container(
              child: new RaisedButton(
                  color: _hometime ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence1),
                  onPressed: () {
                    setState(() {
                      _hometime ? _hometime = false : _hometime = true;
                      _sentence1 == 'Hometime enabled'
                          ? _sentence1 = 'Hometime disabled'
                          : _sentence1 = 'Hometime enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            new Container(
              child: new RaisedButton(
                  color: _sleeptime ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence2),
                  onPressed: () {
                    setState(() {
                      _sleeptime ? _sleeptime = false : _sleeptime = true;
                      _sentence2 == 'Sleeptime enabled'
                          ? _sentence2 = 'Sleeptime disabled'
                          : _sentence2 = 'Sleeptime enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            new Container(
              child: new RaisedButton(
                  color: _pedometre ? Colors.green[200] : Colors.white,
                  child: new Text(_sentence3),
                  onPressed: () {
                    setState(() {
                      _pedometre ? _pedometre = false : _pedometre = true;
                      _sentence3 == 'Pedometre enabled'
                          ? _sentence3 = 'Pedometre disabled'
                          : _sentence3 = 'Pedometre enabled';
                    });
                  }),
              margin: new EdgeInsets.only(top: 20.0),
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
          ],
        ),
      ),
    );
  }
}
}