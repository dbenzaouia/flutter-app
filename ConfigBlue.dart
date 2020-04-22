import 'package:flutter/material.dart';
import 'models/ConfigBlueModel.dart';
import 'data/configBlueManager.dart';
import 'data/database.dart';

class ConfigBlue extends StatefulWidget {
  ConfigBlueState createState() => new ConfigBlueState();
}

class ConfigBlueState extends State<ConfigBlue> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();

  bool _configurationDone;
  String _name1;
  String _name2;
  String _name3;
  String _location1;
  String _location2;
  String _location3;

  @override
  void initState() {
    _configurationDone = false;
    _name1 = '';
    _name2 = '';
    _name3 = '';
    _location1 = '';
    _location2 = '';
    _location3 = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConfigBlueModel configBlue1 =
        ConfigBlueModel(id: 1, name: _name1, location: _location1);
    ConfigBlueModel configBlue2 =
        ConfigBlueModel(id: 2, name: _name2, location: _location2);
    ConfigBlueModel configBlue3 =
        ConfigBlueModel(id: 3, name: _name3, location: _location3);
    if (_configurationDone) {
      ConfigBlueManager(dbProvider).updateConfigBlue(configBlue1, 1);
      ConfigBlueManager(dbProvider).updateConfigBlue(configBlue2, 2);
      ConfigBlueManager(dbProvider).updateConfigBlue(configBlue3, 3);
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
                _name1 = value;
                return null;
              },
              decoration: new InputDecoration(labelText: 'Bluetooth name 1'),
            ),
            new TextFormField(
              validator: (value) {
                _location1 = value;
                return null;
              },
              decoration:
                  new InputDecoration(labelText: 'Bluetooth location 1'),
            ),
            new TextFormField(
              validator: (value) {
                _name2 = value;
                return null;
              },
              decoration: new InputDecoration(labelText: 'Bluetooth name 2'),
            ),
            new TextFormField(
              validator: (value) {
                _location2 = value;
                return null;
              },
              decoration:
                  new InputDecoration(labelText: 'Bluetooth location 2'),
            ),
            new TextFormField(
              validator: (value) {
                _name3 = value;
                return null;
              },
              decoration: new InputDecoration(labelText: 'Bluetooth name 3'),
            ),
            new TextFormField(
              validator: (value) {
                _location3 = value;
                return null;
              },
              decoration:
                  new InputDecoration(labelText: 'Bluetooth location 3'),
            ),
            new Container(
              child: new RaisedButton(
                  child: new Text('Apply'),
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
