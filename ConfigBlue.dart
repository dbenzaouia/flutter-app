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
  bool _configNotLoad;
  String _name1;
  String _name2;
  String _name3;
  String _location1;
  String _location2;
  String _location3;

  @override
  void initState() {
    _configurationDone = false;
    _configNotLoad = true;
    _name1 = '';
    _name2 = '';
    _name3 = '';
    _location1 = '';
    _location2 = '';
    _location3 = '';
    super.initState();
  }

  void loadConfigBlue1() async {
    var _config1 = await dataBase.getConfigBlue(1);
    setState(() {
      _name1 = _config1.name;
      _location1 = _config1.location;
    });
  }

  void loadConfigBlue2() async {
    var _config2 = await dataBase.getConfigBlue(2);
    setState(() {
      _name2 = _config2.name;
      _location2 = _config2.location;
    });
  }

  void loadConfigBlue3() async {
    var _config3 = await dataBase.getConfigBlue(3);
    setState(() {
      _name3 = _config3.name;
      _location3 = _config3.location;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_configNotLoad){
      loadConfigBlue1();
      loadConfigBlue2();
      loadConfigBlue3();
      _configNotLoad = false;
    }

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
      _configurationDone=false;
    }
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
          title: Text("Bluetooth service settings"),
        ),
        body: SingleChildScrollView(
            child: Form(
      key: _formKey,
      child: Padding(
        padding: new EdgeInsets.all(20),
        child: new Column(
          children: <Widget>[
            new Text(
                'Here you can associate a bluetooth device with a location to study how many time you spend in your room or your car for example.',
                style: TextStyle(
                    color: Colors.deepOrange[300],
                    fontStyle: FontStyle.italic)),
            new Text(''),
            Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Please enter the name and the location of your bluetooth device 1'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty==false) {
                              _name1 = value;
                            }
                            
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: _name1,
                              labelText: 'Name device 1'),
                        ),
                      ),
                    ),
            Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty==false) {
                              _location1 = value;
                            }
                            
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: _location1,
                              labelText: 'Location device 1'),
                        ),
                      ),
                    ),
            Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Please enter the name and the location of your bluetooth device 2'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty==false) {
                              _name2 = value;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: _name2,
                              labelText: 'Name device 2'),
                        ),
                      ),
                    ),
            Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty==false) {
                              _location2 = value;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: _location2,
                              labelText: 'Location device 2'),
                        ),
                      ),
                    ),
            Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Please enter the name and the location of your bluetooth device 3'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty==false) {
                              _name3 = value;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: _name3,
                              labelText: 'Name device 3'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 8),
                      child: Card(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty==false) {
                              _location3 = value;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: _location3,
                              labelText: 'Location device 3'),
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
                                      Text('Bluetooth setting has been updated '),
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
    )));
  }
}
