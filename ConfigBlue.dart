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

  void loadConfigBlue() async {
    var _config1 = await dataBase.getConfigBlue(1);
    var _config2 = await dataBase.getConfigBlue(2);
    var _config3 = await dataBase.getConfigBlue(3);
    setState(() {
      _name1 = _config1.name;
      _name2 = _config2.name;
      _name3 = _config3.name;
      _location1 = _config1.location;
      _location2 = _config2.location;
      _location3 = _config3.location;  
    });
  }

  @override
  Widget build(BuildContext context) {
    loadConfigBlue();
    if (_configurationDone) {
      ConfigBlueModel configBlue1 =
        ConfigBlueModel(id: 1, name: _name1, location: _location1);
    ConfigBlueModel configBlue2 =
        ConfigBlueModel(id: 2, name: _name2, location: _location2);
    ConfigBlueModel configBlue3 =
        ConfigBlueModel(id: 3, name: _name3, location: _location3);
      ConfigBlueManager(dbProvider).updateConfigBlue(configBlue1, 1);
      ConfigBlueManager(dbProvider).updateConfigBlue(configBlue2, 2);
      ConfigBlueManager(dbProvider).updateConfigBlue(configBlue3, 3);
    }
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: Form(
      key: _formKey,
      child: Padding(
        padding: new EdgeInsets.all(20),
        child: new Column(
          children: <Widget>[
            new Text('Here you can associate a bluetooth device with a location to study how many time you spend in your room or your car for example.', 
            style: TextStyle(color: Colors.deepOrange[300], fontStyle: FontStyle.italic)
                    ),
            new TextFormField(
              validator: (value) {
                _name1 = value;
                return null;
              },
              decoration: new InputDecoration(labelText:'Name device 1',hintText: _name1),
            ),
            new TextFormField(
              validator: (value) {
                _location1 = value;
                return null;
              },
              decoration:
                  new InputDecoration(labelText:'Location device 1', hintText: _location1),
            ),
            new TextFormField(
              validator: (value) {
                _name2 = value;
                return null;
              },
              decoration: new InputDecoration(labelText:'Name device 2', hintText: _name2),
            ),
            new TextFormField(
              validator: (value) {
                _location2 = value;
                return null;
              },
              decoration:
                  new InputDecoration(labelText:'Location device 2', hintText: _location2),
            ),
            new TextFormField(
              validator: (value) {
                _name3 = value;
                return null;
              },
              decoration: new InputDecoration(labelText:'Name device 3', hintText: _name3),
            ),
            new TextFormField(
              validator: (value) {
                _location3 = value;
                return null;
              },
              decoration:
                  new InputDecoration(labelText: 'Location device 3', hintText: _location3),
            ),
            new Container(
              child: new RaisedButton(
                  child: new Text('Apply'),
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
    ));
  }
  }
