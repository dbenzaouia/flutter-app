import 'package:flutter/material.dart';
import '../widget/blue_widget.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../data/database.dart';
import '../data/BlueManager.dart';
import '../models/blueModel.dart';
import '../widget/list_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../models/ObjectDisplay.dart';
import '../models/ConfigBlueModel.dart';
import '../ConfigBlue.dart';

class BMG extends StatefulWidget {
  BMGState createState() => new BMGState();
}

enum Types { rien, journalier, hebdomadaire, mensuel, annuel }

class BMGState extends State<BMG> {
  DBProvider dbProvider = DBProvider.db;
  final dataBase = DBProvider();
  List<Blue> blues = [];

  List<BlueDay> bluedayfirst = [];

  List<BlueDay> bluedaysecond = [];
  List<BlueDay> bluedaythird = [];
  List<BlueWeek> blueweekfirst;
  List<BlueWeek> blueweekthird;
  List<BlueWeek> blueweeksecond;
  List<BlueMonths> bluemonthsfirst;
  List<BlueMonths> bluemonthsthird;
  List<BlueMonths> bluemonthssecond;
  List<BlueYear> blueyearfirst;
  List<BlueYear> blueyearthird;
  List<BlueYear> blueyearsecond;


  bool configBlue;
  int _changed = 0;
  Types _chang = Types.rien;

  BlueWidgetDay Bday = BlueWidgetDay();
  BlueWidgetYear Byear = BlueWidgetYear();
  BlueWidgetMonths Bmonth = BlueWidgetMonths();
  BlueWidgetWeek Bweek = BlueWidgetWeek();
  var swatch = Stopwatch();
  final dur = Duration(seconds: 1);
  int timeToDisplay=0;



  static ConfigBlueModel make(String nameblue){
  ConfigBlueModel bla=new ConfigBlueModel();
  bla.name=nameblue;
  bla.location=nameblue;
  return bla;
}




  List<ConfigBlueModel> object=[make("bla"),make("nameblue"),make("2")];

  BMGState();

  @override
  void initState() {
    configBlue = false;
    super.initState();
     const fiveSec = const Duration(seconds: 2);
    new Timer.periodic(fiveSec, (Timer t) {
      setup();
    });
    setupList();
    setup();
    swatch.start();
    starttimer();
   
  }
    void keeprunning(){
    if(swatch.isRunning){
      starttimer();
    }
     setState(() {
      timeToDisplay =  (swatch.elapsed.inSeconds);
    });
  }
     void starttimer(){
    Timer(dur, keeprunning);
  }
  
  void setup(){
    setupListDay();
    setupListWeek();
    setupListMonths();
    setupListYear();
    setupConfig();
  }

  int todayDay() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;
  }

  int todayMonths() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    int formattedDate = int.parse(formatter.format(now));
    print(formattedDate);
    return formattedDate;
  }

  int todayYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    int formattedDate = int.parse(formatter.format(now));
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
  void dispose(){
    super.dispose();
    
  }

  String today() {
    var now = new DateTime.now();
    String formattedTime = DateFormat('a').format(now);
    print(formattedTime);
    return formattedTime;
  }

  void setupConfig() async {
    var _object = await dataBase.fetchAllConfigBlue();
    print(_object);
    if(this.mounted){
      setState(() {
      object = _object;
    });
    }
  }

  void setupList() async {
    var _blues = await dataBase.fetchAllBlues();
    print(_blues);
    setState(() {
      blues = _blues;
    });
  }

  void setupListDay() async {
    var _bluedayfirst = await dataBase.getBlueDay(
        (todayYear()), (todayMonths()), (todayDay()), object[0].name);

    var _bluedaysecond = await dataBase.getBlueDay(
        (todayYear()), (todayMonths()), (todayDay()), object[1].name);

    var _bluedaythird = await dataBase.getBlueDay(
        (todayYear()), (todayMonths()), (todayDay()), object[2].name);
    if(this.mounted){
      setState(() {
      bluedaythird = _bluedaythird;
      bluedaysecond = _bluedaysecond;
      bluedayfirst = _bluedayfirst;
    });
    }
  }

  void setupListWeek() async {
    var _blueweekfirst = await dataBase.getBlueWeek(
        (todayYear()), (todayMonths()), (todayDay()), object[0].name);
    var _blueweeksecond = await dataBase.getBlueWeek(
        (todayYear()), (todayMonths()), (todayDay()), object[1].name);
    var _blueweekthird = await dataBase.getBlueWeek(
        (todayYear()), (todayMonths()), (todayDay()), object[2].name);
    if (this.mounted){
 

    setState(() {
      blueweekthird = _blueweekthird;
      blueweeksecond = _blueweeksecond;
      blueweekfirst = _blueweekfirst;
    });
    }
  }

  void setupListMonths() async {
    var _bluemonthsfirst =
        await dataBase.getBlueMonths((todayYear()), object[0].name);
    var _bluemonthssecond =
        await dataBase.getBlueMonths((todayYear()), object[1].name);
    var _bluemonthsthird =
        await dataBase.getBlueMonths((todayYear()), object[2].name);
    if(this.mounted){
    setState(() {
      bluemonthsthird = _bluemonthsthird;
      bluemonthssecond = _bluemonthssecond;
      bluemonthsfirst = _bluemonthsfirst;
    });
    }
  }

  void setupListYear() async {
    var _blueyearfirst =
        await dataBase.getBlueYear((todayYear()), object[0].name);
    var _blueyearsecond =
        await dataBase.getBlueYear((todayYear()), object[1].name);
    var _blueyearthird =
        await dataBase.getBlueYear((todayYear()), object[2].name);
    if(this.mounted){
    setState(() {
      blueyearthird = _blueyearthird;
      blueyearsecond = _blueyearsecond;
      blueyearfirst = _blueyearfirst;
    });
    }
  }

  Widget build(BuildContext context) {
    List<charts.Series<BlueDay, DateTime>> series = withSampleData();
    List<charts.Series<BlueWeek, String>> seriesweek = withSampleDataWeek();
    List<charts.Series<BlueMonths, String>> seriesmonths =withSampleDataMonths();
    List<charts.Series<BlueYear, String>> seriesyear = withSampleDataYear();
    if (timeToDisplay<10){
      return Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth"),
        ),
        body: SingleChildScrollView(
          //margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 300.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
            height:350,
            width: 450.0,
            child: Stack(
              children: <Widget>[
                       Center(
                            child: Text('Loading...')
                          ),
              ]
                )
              )
            ],
          ),
        ),
      );

    }
    else{
    

    // The children consist of a Chart and Text widgets below to hold the info.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Bluetooth"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'Daily',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              Tab(
                  child: Text(
                'Weekly',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )),
              Tab(
                  child: Text(
                'Monthly',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Bday.BlueWidget(series,bluedayfirst,bluedaysecond,bluedaythird, object),
            Bweek.BlueWidget(seriesweek, blueweekfirst, blueweeksecond, blueweekthird, object),
            Bmonth.BlueWidget(seriesmonths, bluemonthsfirst, bluemonthssecond, bluemonthsthird, object),
          ],
        ),
      ),
    );
  }
  }

  withSampleData() {
    return (_createSampleData());
  }

  withSampleDataWeek() {
    return (_createSampleDataWeek());
  }

  withSampleDataMonths() {
    return (_createSampleDataMonths());
  }

  withSampleDataYear() {
    return (_createSampleDataYear());
  }

  List<charts.Series<BlueDay, DateTime>> _createSampleData() {
    return [
      new charts.Series<BlueDay, DateTime>(
        id: '${object[0].name}/${object[0].location}',
        domainFn: (BlueDay bluedayfirst, _) => DateTime(
            int.parse(bluedayfirst.theYear),
            int.parse(bluedayfirst.theMonth),
            int.parse(bluedayfirst.theDay),
            int.parse(bluedayfirst.theHour)),
        measureFn: (BlueDay bluedayfirst, _) => bluedayfirst.theTime,

        data: bluedayfirst,

        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueDay, DateTime>(
        id: '${object[1].name}/${object[1].location}',
        domainFn: (BlueDay bluedaysecond, _) => DateTime(
            int.parse(bluedaysecond.theYear),
            int.parse(bluedaysecond.theMonth),
            int.parse(bluedaysecond.theDay),
            int.parse(bluedaysecond.theHour)),
        measureFn: (BlueDay bluedaysecond, _) => bluedaysecond.theTime,

        data: bluedaysecond,
        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueDay, DateTime>(
        id: '${object[2].name}/${object[2].location}',
        domainFn: (BlueDay bluedaythird, _) => DateTime(
            int.parse(bluedaythird.theYear),
            int.parse(bluedaythird.theMonth),
            int.parse(bluedaythird.theDay),
            int.parse(bluedaythird.theHour)),
        measureFn: (BlueDay bluedaythird, _) => bluedaythird.theTime,

        data: bluedaythird,
        // Set a label accessor to control the text of the bar label.
      ),
    ];
  }

  List<charts.Series<BlueWeek, String>> _createSampleDataWeek() {
    return [
      new charts.Series<BlueWeek, String>(
        id: '${object[0].name}/${object[0].location}',
        domainFn: (BlueWeek blueweekfirst, _) =>
            blueweekfirst.beginDate + "-" + blueweekfirst.endDate,
        measureFn: (BlueWeek blueweekfirst, _) => blueweekfirst.theTime,

        data: blueweekfirst,

        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueWeek, String>(
        id: '${object[1].name}/${object[1].location}',
        domainFn: (BlueWeek blueweeksecond, _) =>
            blueweeksecond.beginDate + "-" + blueweeksecond.endDate,
        measureFn: (BlueWeek blueweeksecond, _) => blueweeksecond.theTime,

        data: blueweeksecond,
        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueWeek, String>(
        id: '${object[2].name}/${object[2].location}',
        domainFn: (BlueWeek blueweekthird, _) =>
            blueweekthird.beginDate + "-" + blueweekthird.endDate,
        measureFn: (BlueWeek blueweekthird, _) => blueweekthird.theTime,

        data: blueweekthird,
        // Set a label accessor to control the text of the bar label.
      ),
    ];
  }

  List<charts.Series<BlueMonths, String>> _createSampleDataMonths() {
    return [
      new charts.Series<BlueMonths, String>(
        id: '${object[0].name}/${object[0].location}',
        domainFn: (BlueMonths bluemonthsfirst, _) => bluemonthsfirst.theMonths,
        measureFn: (BlueMonths bluemonthsfirst, _) => bluemonthsfirst.theTime,

        data: bluemonthsfirst,

        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueMonths, String>(
        id: '${object[1].name}/${object[1].location}',
        domainFn: (BlueMonths bluemonthssecond, _) =>
            bluemonthssecond.theMonths,
        measureFn: (BlueMonths bluemonthssecond, _) => bluemonthssecond.theTime,

        data: bluemonthssecond,
        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueMonths, String>(
        id: '${object[2].name}/${object[2].location}',
        domainFn: (BlueMonths bluemonthsthird, _) => bluemonthsthird.theMonths,
        measureFn: (BlueMonths bluemonthsthird, _) => bluemonthsthird.theTime,

        data: bluemonthsthird,
        // Set a label accessor to control the text of the bar label.
      ),
    ];
  }

  List<charts.Series<BlueYear, String>> _createSampleDataYear() {
    return [
      new charts.Series<BlueYear, String>(
        id: '${object[0].name}/${object[0].location}',
        domainFn: (BlueYear blueyearfirst, _) => blueyearfirst.theYear,
        measureFn: (BlueYear blueyearfirst, _) => blueyearfirst.theTime,

        data: blueyearfirst,

        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueYear, String>(
        id: '${object[1].name}/${object[1].location}',
        domainFn: (BlueYear blueyearsecond, _) => blueyearsecond.theYear,
        measureFn: (BlueYear blueyearsecond, _) => blueyearsecond.theTime,

        data: blueyearsecond,
        // Set a label accessor to control the text of the bar label.
      ),
      new charts.Series<BlueYear, String>(
        id: '${object[2].name}/${object[2].location}',
        domainFn: (BlueYear blueyearthird, _) => blueyearthird.theYear,
        measureFn: (BlueYear blueyearthird, _) => blueyearthird.theTime,

        data: blueyearthird,
        // Set a label accessor to control the text of the bar label.
      ),
    ];
  }
}