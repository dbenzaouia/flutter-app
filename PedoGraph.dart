import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/data/database.dart';
import 'package:flutter_app/data/stepsManager.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/widget/list_widget.dart';
import 'package:intl/intl.dart';
import 'widget/pedometer_widget.dart';

import 'package:flutter_app/widget/pedometer_widget.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';




class PedoGraph extends StatefulWidget {
   List<DateTime> data=[DateTime(2020,4,16)];
    PedoGraphState createState() => new PedoGraphState(data:this.data);

 
}
  enum Types { rien,journalier, hebdomadaire, mensuel,annuel }

class PedoGraphState extends State<PedoGraph> {
  PedoGraphState({Key key,List<DateTime> this.data});

  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<Steps> steps = [];
  List<StepsDay> stepsday = [];
  List<StepsDays> stepsdays = [];
  final List<DateTime> data;

  List<StepsMonths> stepsmonths =[];
  List<StepsDays> stepsweek =[];


  int day=0;
  int months=0;
  int year=0;
  int hours=0;
  int min=0;
  String part="";
  int _changed=0;
  PedometerWidget pd = new PedometerWidget();
  PedometerWidgetAnnuel pda = new PedometerWidgetAnnuel();
  PedometerWidgetMonths pdm = new PedometerWidgetMonths();
  PedometerWidgetWeek pdw = new PedometerWidgetWeek();

  DateTime _dateTime;
  String MIN_DATETIME =  "01-01-01";
  String MAX_DATETIME = "2020-12-31";
  String INIT_DATETIME = '2019-05-16';
  String DATE_FORMAT = 'yyyy-MM-dd';
  int years=0;
    int monthss=0;
    int days=0;
 

  @override
  String todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    var formattedDate = (formatter.format(now));
    print(formattedDate);
    return formattedDate;
  }
  String todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    var formattedDate = (formatter.format(now));
    print(formattedDate);
    return formattedDate;

  }
  String todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = (formatter.format(now));
    print(formattedDate);
    return formattedDate;

  }
  int todayHours() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('kk').format(now));
    print(formattedTime);
    return formattedTime;
  }
  int todayMin() {
    var now = new DateTime.now();
    int formattedTime = int.parse(DateFormat('mm').format(now));
    print(formattedTime);
    return formattedTime;

  }
  String today() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('a').format(now);
    print(formattedTime);
    return formattedTime;


  }

   
 

 

 

  void initState() {
    super.initState();
      print(data);

    setupList();
    setupListDay();
    setupListMonths();
    setupListDays();
    setupListWeek();
    INIT_DATETIME=todayYear().toString()+"-"+todayMonths().toString()+"-"+todayDay().toString();
    print("date init");
    print(INIT_DATETIME);
    _dateTime = DateTime.parse(INIT_DATETIME);
        print(data);


    data.add(_dateTime);
    
    MIN_DATETIME =  (int.parse(todayYear())-1).toString()+"-01-01";
    MAX_DATETIME = (todayYear()).toString()+"-12-31";
    _save();
    print("date");
    print(_dateTime);
    
  }

 
    

 
  void setupList() async{
    var _steps = await dataBase.fetchAll();
    print(_steps);
    setState(() {
      steps = _steps;
    });
  }

// ...




  
 
 Widget build(BuildContext context) {
    List<charts.Series<StepsDay, String>> series = withSampleData();
    List<charts.Series<StepsMonths, String>> seriesmonths = withSampleDatamonths();
    List<charts.Series<StepsDays, String>> seriesdays = withSampleDataDays();
    List<charts.Series<StepsDays, String>> seriesweek = withSampleDataWeek();

    

    Types _chang = Types.rien;


      if(_changed==0)
       return new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Center(
                heightFactor: 20,
                child: Text(
                  'Types de graphes',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), 
               Column(
                children: <Widget>[
                  ListTile(
                  title: const Text('journalier'),
                  leading: Radio(
                  value: Types.journalier,
                  groupValue: _chang,

                  onChanged: (Types value) {
                  setState(() { _chang = value;
                  _changed=1;
                  });
                  },
                ),
               ),
       
              ListTile(
                title: const Text('hebdomadaire'),
                leading: Radio(
                value: Types.hebdomadaire,
                groupValue: _chang,

                onChanged: (Types value) {
                setState(() { _chang = value;
                              _changed=2;
                 });
                },
              ),
            ),
            ListTile(
              title: const Text('mensuel'),
              leading: Radio(
              value: Types.mensuel,
              groupValue: _chang,

              onChanged: (Types value) {
              setState(() { _chang = value; 
                           _changed=3;
                });
              },
              ),
            ),
            ListTile(
              title: const Text('annuel'),
              leading: Radio(
              value: Types.annuel,
              groupValue: _chang,

              onChanged: (Types value) {
               setState(() { _chang = value; 
                            _changed=4;

               });
             },
            ),
            ),
          ],
           ),
              Container(
              margin: EdgeInsets.only(top: 8.0, bottom: 40.0),
              child: DateTimePickerWidget(
                minDateTime: DateTime.parse(MIN_DATETIME),
                maxDateTime: DateTime.parse(MAX_DATETIME),
                initDateTime: DateTime.parse(INIT_DATETIME),
                dateFormat: DATE_FORMAT,
                pickerTheme: DateTimePickerTheme(
                  showTitle: false,
                  title: Container(
                    width: double.infinity,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: Text('Date Time Picker Title'),
                    decoration: BoxDecoration(color: Color(0xFFc0ca33)),
                  ),
                  backgroundColor: Color(0xFFf0f4c3),
                ),
                onChange: (dateTime, selectedIndex) {
                  setState(() {
                    _dateTime = dateTime;
                    print("ici");
                    years=dateTime.year;
                    monthss=dateTime.month;
                    days=dateTime.day;
                        _save();
                    data.add(dateTime);



                        

                            
                         
                         
                        
                      

                  });
                },
              ),
            ),
                 Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Selected DateTime:',
                    style: Theme.of(context).textTheme.subhead),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    _dateTime != null
                        ? '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}'
                        : '',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ]
            ),
            ],
          ),
      );


             
            
              /*RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                     _changed = 1;
                  });
                },
                child: Text(
                  'Graphique journalier',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                     _changed = 4;
                  });
                },
                child: Text(
                  'Graphique hebdomadaire',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
               RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                     _changed = 3;
                  });
                },
                child: Text(
                  'Graphique mensuel',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setupList();
                  setState(() {
                    _changed = 2;
                  });
                },
                child: Text(
                  'Graphique annuel',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
        */
    else if (_changed==1){
        return pd.pedometerWidget(50, series,stepsday);
    }
    else if(_changed==2){
        return pda.pedometerWidget(50, seriesmonths,stepsmonths);

    }
      else if(_changed==3){
        return pdm.pedometerWidget(50, seriesdays,stepsdays);

    }
    else if(_changed==4){
        return pdw.pedometerWidget(50, seriesweek,stepsweek);

    }
        /*(
        alignment: Alignment.center,
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                         RaisedButton(
                onPressed: () {
                  setState(() {
                    _changed ? _changed = false : _changed = true;
                  });
                },
                child: Text(
                  'Acquisition',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
                        Text(
                          "Number of steps",
                          style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                        Container(
                          width: 300,
                          height: 200,
                          child: charts.BarChart(series, animate: true),
                        ),
                      ],
                    
                  ),
                ),
              ), 
              new RepaintBoundary(
                child: new SizedBox(
                height: 192.0,
                child: BuildStepList().buildStepList(steps),
               ),
              ),   
               ]
                  
        ),
       
        
      );    }*/
  }
  void setupListDay() async{
    print("aneeee");
    //print(_dateTime.year);
    var _stepsday = await dataBase.getStepsDay(int.parse(todayYear()),int.parse(todayMonths()),int.parse(todayDay()));
    print(_stepsday);
    setState(() {
      stepsday = _stepsday;
    });
  }
    void setupListMonths() async{
      print(years);
      print(monthss);
      print(days);
    var _stepsmonths = await dataBase.getStepsMonths(int.parse(todayYear()));
    print(_stepsmonths);
    setState(() {
      stepsmonths = _stepsmonths;
    });
  }
   _save() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'my_int_key';
    final prefs3 = await SharedPreferences.getInstance();
    final key3 = 'my_int_key';
    years=_dateTime.year;

      prefs.setInt(key, years);
      prefs2.setInt(key2, _dateTime.month);
      prefs3.setInt(key3, _dateTime.day);
          print('saved $years');
    print('saved ${_dateTime.year}');
    print('saved ${_dateTime.year}');



    }

    void setupListDays() async{
      print('saved f $years');
    print('saved f $monthss');
    print('saved  f $days');
    var _stepsdays = await dataBase.getStepsperDay(int.parse(todayYear()),int.parse(todayMonths()));
    print(_stepsdays);
    setState(() {
      stepsdays = _stepsdays;
    });
  }
   void setupListWeek() async{
    DateTime datas=data[data.length-1];
    print(datas);
    var _stepsweek = await dataBase.getStepsWeek(int.parse(todayYear()),int.parse(todayMonths()),int.parse(todayDay()));
    print(_stepsweek);
    setState(() {
      stepsweek = _stepsweek;
    });
  }

  withSampleData() {
    
    return (
      _createSampleData()
    );
  }
  withSampleDataDays(){
    
    return (
      _createSampleDataDays()
    );
  }
  withSampleDatamonths() {
    
    return (
      _createSampleDatamonths()
    );
  }
   withSampleDataWeek() {
    
    return (
      _createSampleDataWeek()
    );
  }
  List<charts.Series<StepsDays, String>>   _createSampleDataDays(){

    return [
      new charts.Series<StepsDays, String>(
          id: 'StepsDays',
          domainFn: (StepsDays stepsdays, _) => stepsdays.theDay,
          measureFn: (StepsDays stepsdays, _) => stepsdays.numberSteps,
          data: stepsdays,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsDays stepsdays, _) =>
          '${stepsdays.numberSteps.toString()} pas'),     
    ];
  } 
   List<charts.Series<StepsDays, String>>   _createSampleDataWeek(){

    return [
      new charts.Series<StepsDays, String>(
          id: 'StepsWeek',
          domainFn: (StepsDays stepsweek, _) => stepsweek.theDay,
          measureFn: (StepsDays stepsweek, _) => stepsweek.numberSteps,
          data: stepsweek,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsDays stepsweek, _) =>
          '${stepsweek.numberSteps.toString()} pas'),     
    ];
  } 

  List<charts.Series<StepsDay, String>> _createSampleData() {

    return [
      new charts.Series<StepsDay, String>(
          id: 'StepsDay',
          domainFn: (StepsDay stepsday, _) => stepsday.theHour,
          measureFn: (StepsDay stepsday, _) => stepsday.numberSteps,
          data: stepsday,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsDay stepsday, _) =>
          '${stepsday.numberSteps.toString()} pas'),     
    ];
  } 
    List<charts.Series<StepsMonths, String>> _createSampleDatamonths() {

    return [
      new charts.Series<StepsMonths, String>(
          id: 'StepsMonths',
          domainFn: (StepsMonths stepsmonths, _) => stepsmonths.theMonths,
          measureFn: (StepsMonths stepsmonths, _) => stepsmonths.numberSteps,
          data: stepsmonths,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StepsMonths stepsmonths, _) =>
          '${stepsmonths.numberSteps.toString()} pas'),     
    ];
  }
}
